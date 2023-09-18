const dbQuery = require('./dbUtils');
const upload = require('./multerConfig');
const db = require('./database');
const { handleDbError } = require('./errorHandlers');
const { getRelativePath } = require('../public/tools/function');
const queryAsync = (connection, sql, params) => new Promise((resolve, reject) => {
    connection.query(sql, params, (error, results) => {
        if (error) {
            reject(error);
        } else {
            resolve(results);
        }
    });
});
exports.getProducts = (req, res) => {
    const query = `
    SELECT sellspec.*, product.prod_name, pi.img_src
    FROM sellspec
    INNER JOIN product ON sellspec.prod_id = product.prod_id
    LEFT JOIN (
        SELECT prod_id, MIN(id) as first_image_id 
        FROM product_images_test 
        WHERE products_info = 0
        GROUP BY prod_id
    ) as first_images ON sellspec.prod_id = first_images.prod_id
    LEFT JOIN product_images_test pi ON pi.prod_id = first_images.prod_id AND pi.id = first_images.first_image_id
    WHERE sellspec.publish = 1 AND pi.products_info = 0
    ORDER BY sellspec.prod_id
    `;

    db.query(query, (err, results) => {
        if (err) throw err;
        res.json(results);
    });
};



exports.getDownProducts = (req, res) => {
    const query = `
    SELECT sellspec.*, product.prod_name, product_images_test.img_src
    FROM sellspec
    INNER JOIN product ON sellspec.prod_id = product.prod_id
    LEFT JOIN product_images_test ON sellspec.prod_id = product_images_test.prod_id
    WHERE sellspec.publish = 0 AND products_info = 0
    ORDER BY sellspec.prod_id
    `;

    db.query(query, (err, results) => {
        if (err) throw err;
        res.json(results);
    });
};


exports.getImage = (req, res) => {
    const query = `
    SELECT * FROM product_images_test
    `;

    db.query(query, (err, results) => {
        if (err) throw err;
        res.json(results);
    });
};



exports.updateProduct = (req, res) => {
    const productId = req.params.productId;
    const { publish } = req.body;

    db.query('UPDATE sellspec SET publish = ? WHERE prod_id = ?', [publish, productId], (err, results) => {
        if (err) {
            res.status(500).json({ error: 'Database error' });
            throw err;
        }

        if (results.affectedRows === 0) {
            res.status(404).json({ message: 'Product not found' });
        } else {
            res.json({ message: '成功更新資訊' });
        }
    });
};

exports.createProduct = [upload.array('productImage', 6), (req, res, next) => {
    console.log(req.body);
    next();
}, async (req, res) => {



    const mainImageIdx = Number(req.body.mainImageIdx);
    const {
        productData: {
            cpu, gpu, ram, os, screen, battery,
            warranty, size, weight, price, description, spec
        },
        prod_name, brand_id, category_id, transport, payment
    } = req.body;

    const productData = {
        user_id: req.body.productData.user_id,
        prod_name: req.body.productData.prod_name,
        brand_id: req.body.productData.brand_id,
        category_id: req.body.productData.category_id,
        transport: req.body.productData.transport,
        payment: req.body.productData.payment,

    }
    try {
        const results = await dbQuery('INSERT INTO product SET ?', productData);
        const prodId = results.insertId;
        const publishValue = req.body.productData.publish;
        const quantityValue = req.body.productData.quantity;
        const DEFAULT_IMAGE_PATH = "/images/products/defaultImage.jpg";

        let imagesData = [];

        if (req.files && req.files.length > 0) {
            imagesData = req.files.map((file, idx) => {
                let relativePath;
                if (file.path) {
                    relativePath = getRelativePath(file.path);
                }
                return {
                    prod_id: prodId,
                    originalname: file.originalname,
                    stored_name: file.filename,
                    upload_date: new Date(),
                    file_size: file.size,
                    mime_type: file.mimetype,
                    img_src: relativePath,
                    products_info: mainImageIdx === idx ? 0 : 1
                };
            });
        } else {
            // 如果沒有上傳圖片，使用預設圖片
            imagesData.push({
                prod_id: prodId,
                originalname: "defaultImage.jpg",
                stored_name: "defaultImage.jpg",
                upload_date: new Date(),
                file_size: "999", // defaultData
                mime_type: "image/jpeg",
                img_src: DEFAULT_IMAGE_PATH,
                products_info: 0 // defaultPic
            });

        }

        const imgInsertPromises = imagesData.map(imgData => {
            return dbQuery('INSERT INTO product_images_test SET ?', imgData);
        });

        await Promise.all(imgInsertPromises);
        const sellSpecData = {
            prod_id: prodId,
            spec_id: '10',
            spec_name: spec,
            contnet: description,
            price: price,
            cpu,
            gpu,
            ram,
            os,
            screen,
            battery,
            warranty,
            size,
            weight,
            publish: publishValue,
            stock: quantityValue
        };

        await dbQuery('INSERT INTO sellspec SET ?', sellSpecData);
        res.json({ success: true, message: 'Product and images added successfully!' });
    } catch (error) {
        console.error("Error:", error);
        handleDbError(error, res);
    }
}];

exports.getProductsAllData = async (req, res) => {
    const prodId = req.params.prod_id;

    try {

        const productResults = await dbQuery('SELECT * FROM product WHERE prod_id = ?', [prodId]);

        if (productResults.length > 0) {
            const brandId = productResults[0].brand_id;
            const categoryId = productResults[0].category_id;


            const brandResults = await dbQuery('SELECT * FROM brand WHERE brand_id = ?', [brandId]);
            productResults[0].brandName = brandResults.length > 0 ? brandResults[0].brand : null;


            const categoryResults = await dbQuery('SELECT * FROM category WHERE category_id = ?', [categoryId]);
            productResults[0].categoryName = categoryResults.length > 0 ? categoryResults[0].category : null;
        }

        const imagesResults = await dbQuery('SELECT * FROM product_images_test WHERE prod_id = ?', [prodId]);
        const sellspecResults = await dbQuery('SELECT * FROM sellspec WHERE prod_id = ?', [prodId]);

        // 整合資訊並返回
        const responseData = {
            product: productResults[0],
            images: imagesResults,
            sellspec: sellspecResults
        };

        res.json(responseData);

    } catch (error) {
        console.error("Database error:", error);
        res.status(500).json({ error: "Failed to retrieve product details." });
    }

};
exports.partiallyUpdateProduct = (req, res) => {
   
    const { prod_id } = req.params;
    const updatedData = req.body;
    const sellspecData = updatedData.sellspec[0];
    const sellspecFields = [];
    const sellspecParams = [];

    const fieldMapping = {
        prod_name: "prod_name",
        brandId: "brand_id",
        categoryId: "category_id",
        transport: "transport",
        payment: "payment"
        
    };

    const sellspecMapping = {
        spec_name: "spec_name",
        price: "price",
        cpu: "cpu",
        gpu: "gpu",
        ram: "ram",
        os: "os",
        screen: "screen",
        battery: "battery",
        warranty: "warranty",
        size: "size",
        weight: "weight",
        stock: "stock"
    };

    if (!updatedData.prod_name) {
        return res.status(400).json({ message: "Product name is required" });
    }

    const fields = [];
    const params = [];

    for (let key in updatedData) {
        if (fieldMapping[key]) {
            fields.push(`${fieldMapping[key]} = ?`);
            params.push(updatedData[key]);
        }
    }

    for (let key in sellspecData) {
        if (sellspecMapping[key]) {
            let value = key === 'price' ? Number(sellspecData[key]) : sellspecData[key];
            sellspecFields.push(`${sellspecMapping[key]} = ?`);
            sellspecParams.push(value);
        }
    }


    const sql = `UPDATE product SET ${fields.join(', ')} WHERE prod_id = ?`;
    params.push(prod_id);

    const sellspecSql = `UPDATE sellspec SET ${sellspecFields.join(', ')} WHERE prod_id = ?`;
    sellspecParams.push(prod_id);

    db.getConnection(async (err, connection) => {
        if (err) {
            console.error("連接到資料庫時出錯: ", err.message || err);
            return res.status(500).json({ message: "內部伺服器錯誤", error: err.message });
        }
        try {
            // 使用 promisify 後的查詢函數
            await queryAsync(connection, sql, params);
            await queryAsync(connection, sellspecSql, sellspecParams);

            res.json({ message: "產品和 sellspect 已成功更新" });
        } catch (error) {
            console.error("資料庫操作期間出錯: ", error.message || error);
            res.status(500).json({ message: "內部伺服器錯誤", error: error.message });
        } finally {
            connection.release();
        }
    });
    console.log('接收到的數據:', updatedData);
    console.log("Executing SQL:", sql);
    console.log("With params:", params);

    console.log("Executing Sellspec SQL:", sellspecSql);
    console.log("With Sellspec params:", sellspecParams);


    // SELL更新

}