const express = require('express');
const app = express();
const router = express.Router();
const multer = require('multer');
const path = require('path');
const db = require('./database');  // 注意相對路徑



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


router.post('/createProduct', upload.single('productImage'), (req, res) => {
    console.log("req.file:", req.file);
    let relativePath; // 先宣告 relativePath 變數

    if (req.file && req.file.path) {
        relativePath = getRelativePath(req.file.path); // 在此賦值
    }

    if (!req.body || !req.file) {
        return res.status(400).json({ message: '請求數據不完整' });
    }



    const productData = req.body;
    
    const productId = req.body.product_id;

    const data = {
        prod_id: productId,
        originalname: req.file.originalname,
        stored_name: req.file.filename,
        upload_date: new Date(),
        file_size: req.file.size,
        mime_type: req.file.mimetype,
        img_src: relativePath,
        
    };
    console.log(req.file.originalname);
    console.log(relativePath);

    // 插入到 product table
    db.query('INSERT INTO product SET ?', productData, (error, results) => {
        if (error) {
            console.error("Database error:", error);
            return res.json({ success: false, message: 'Database insertion failed' });
        }

        // 新插入的商品ID
        const prodId = results.insertId;

        data.prod_id = prodId; // 將 data 的 product_id 設定為新的商品ID

        // 插入到 product_images_test 表
        db.query('INSERT INTO product_images_test SET ?', data, (imgError) => {
            if (imgError) {
                console.error("Image insertion error:", imgError);
                return res.json({ success: false, message: 'Image insertion failed' });
            }
            res.json({ success: true, message: 'Product and image added successfully!' });
        });
    });
});


module.exports = router;
