<<<<<<< HEAD
const express = require('express');
const app = express();
const router = express.Router();
const multer = require('multer');
const path = require('path');
const db = require('./database');  // 注意相對路徑

const logger = require('../../../../public/images/tools/logger');

// logger.info('This is an info message');
// logger.warn('This is a warning message');
// logger.error('This is an error message');

app.use(express.json()); // 用於解析JSON請求
app.use(express.urlencoded({ extended: true })); // 用於解析表單數據

// 抓品牌的路由
router.get('/brand', (req, res) => {
    const query = `
    SELECT * FROM brand
    `;

    db.query(query, (err, results) => {
        if (err) throw err;
        res.json(results);
    });
});


// 分類的路由
router.get('/category', (req, res) => {
    const query = `
    SELECT * FROM category
    `;

    db.query(query, (err, results) => {
        if (err) throw err;
        res.json(results);
    });
});


// 產品細節路由
router.get('/products', (req, res) => {
    const query = `
        SELECT sellspec1.*, product.prod_name
        FROM sellspec1
        INNER JOIN product ON sellspec1.prod_id = product.prod_id
        WHERE sellspec1.publish = 1
        ORDER BY sellspec1.id
    `;

    db.query(query, (err, results) => {
        if (err) throw err;
        res.json(results);
    });
});


// 下架商品路由
router.get('/downproducts', (req, res) => {
    const query = `
    SELECT sellspec1.*, product.prod_name
    FROM sellspec1
    INNER JOIN product ON sellspec1.prod_id = product.prod_id
    WHERE sellspec1.publish = 0
    ORDER BY sellspec1.id
`;

    db.query(query, (err, results) => {
        if (err) throw err;
        res.json(results);
    });
});

router.put('/down/:productId', (req, res) => {
    const productId = req.params.productId;
    const { publish } = req.body;


    db.query('UPDATE sellspec1 SET publish = ? WHERE id = ?', [publish, productId], (err, results) => {
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
});





router.get('/uploaddata', (req, res) => {
    const query = `
    SELECT * FROM product_images_test
`;

    db.query(query, (err, results) => {
        if (err) throw err;
        res.json(results);
    });
});


// 上傳圖片
// 設定 multer - 考慮將這些配置放入一個單獨的文件或模組
const storage = multer.diskStorage({
    destination: function (req, file, cb) {
        cb(null, path.join(__dirname, '..', 'public', 'images', 'testimg')) // 使用相對路徑定位到 'testimg' 目錄
    },
    filename: function (req, file, cb) {
        cb(null, Date.now() + '-' + file.originalname) // 使用當前日期時間加原始文件名作為新的文件名
    }
});
const upload = multer({ storage: storage });
function getRelativePath(absolutePath) {
    console.log("Absolute Path:", absolutePath);
    let relativePath = path.relative(path.join(__dirname, '..', 'public'), absolutePath);
    console.log("Generated Relative Path:", relativePath);
    return relativePath.replace(/\\/g, '/');
}

const dbQuery = (query, values) => {
    return new Promise((resolve, reject) => {
        db.query(query, values, (error, results) => {
            if (error) {
                reject(error);
            } else {
                resolve(results);
            }
        });
    });
};

router.post('/createProduct', upload.array('productImage', 5), (req, res, next) => {
    console.log('Endpoint hit!');
    console.log('Received body data:', req.body);
    console.log('Received files:', req.files);
    // Check and log keys of req.files
    if (req.files) {
        console.log(Object.keys(req.files));
    } else {
        console.log("req.files is not defined or null");
    }

    console.log(req.body);

    next();
}, async (req, res) => {
    if (!req.body || !req.files || req.files.length === 0) {
        return res.status(400).json({ message: '請求數據不完整' });
    }

    const productData = {
        user_id: req.body.productData.user_id,
        prod_name: req.body.productData.prod_name,
        brand_id: req.body.productData.brand_id,
        category_id: req.body.productData.category_id,
        transport: req.body.productData.transport,
        payment: req.body.productData.payment,
        // ... 其他字段
      };
    try {
        // 插入到 product table
        const results = await dbQuery('INSERT INTO product SET ?', productData);
        const prodId = results.insertId;

        let imagesData = req.files.map(file => {
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
            };
        });

        const imgInsertPromises = imagesData.map(imgData => {
            return dbQuery('INSERT INTO product_images_test SET ?', imgData);
        });

        await Promise.all(imgInsertPromises);
        res.json({ success: true, message: 'Product and images added successfully!' });

    } catch (error) {
        console.error("Error:", error);

        if (error.code === 'ER_DUP_ENTRY') {
            res.status(400).json({ success: false, message: 'Duplicate entry detected!' });
        } else {
            res.status(500).json({ success: false, message: 'Server error.' });
        }
    }
});



module.exports = router;

=======
const express = require('express')
const router = express.Router()
const productController = require('./productController')
>>>>>>> 81d0a160920946ac25c9ff540145f775eb79d02b

router.get('/products', productController.getProducts)
router.get('/image', productController.getImage)
router.get('/downproducts', productController.getDownProducts)
router.put('/down/:productId', productController.updateProduct)
router.post('/createProduct', productController.createProduct)
router.get('/getProductsAllData/:prod_id', productController.getProductsAllData)
router.patch('/updateProductPartially/:prod_id', productController.partiallyUpdateProduct)

module.exports = router
