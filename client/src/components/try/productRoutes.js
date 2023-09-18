// const express = require('express');
// const app = express();
// const router = express.Router();
// const multer = require('multer');
// const path = require('path');
// const db = require('./database');  // 注意相對路徑


// const logger = require('../../../../server/public/tools/logger');

// logger.info('This is an info message');
// logger.warn('This is a warning message');
// logger.error('This is an error message');

// app.use(express.json()); // 用於解析JSON請求
// app.use(express.urlencoded({ extended: true })); // 用於解析表單數據 


// // 產品細節路由
// router.get('/products', (req, res) => {
//     const query = `
//         SELECT sellspec1.*, product.prod_name
//         FROM sellspec1
//         INNER JOIN product ON sellspec1.prod_id = product.prod_id
//         WHERE sellspec1.publish = 1
//         ORDER BY sellspec1.id
//     `;

//     db.query(query, (err, results) => {
//         if (err) throw err;
//         res.json(results);
//     });
// });


// // 下架商品路由
// router.get('/downproducts', (req, res) => {
//     const query = `
//     SELECT sellspec1.*, product.prod_name
//     FROM sellspec1
//     INNER JOIN product ON sellspec1.prod_id = product.prod_id
//     WHERE sellspec1.publish = 0
//     ORDER BY sellspec1.id
// `;

//     db.query(query, (err, results) => {
//         if (err) throw err;
//         res.json(results);
//     });
// });

// router.put('/down/:productId', (req, res) => {
//     const productId = req.params.productId;
//     const { publish } = req.body;


//     db.query('UPDATE sellspec SET publish = ? WHERE prod_id = ?', [publish, productId], (err, results) => {
//         if (err) {
//             res.status(500).json({ error: 'Database error' });
//             throw err;
//         }

//         if (results.affectedRows === 0) {
//             res.status(404).json({ message: 'Product not found' });
//         } else {
//             res.json({ message: '成功更新資訊' });
//         }
//     });
// });





// // 上傳圖片
// // 設定 multer - 考慮將這些配置放入一個單獨的文件或模組
// const storage = multer.diskStorage({
//     destination: function (req, file, cb) {
//         cb(null, path.join(__dirname, '..', 'public', 'images', 'testimg')) // 使用相對路徑定位到 'testimg' 目錄
//     },
//     filename: function (req, file, cb) {
//         cb(null, Date.now() + '-' + file.originalname) // 使用當前日期時間加原始文件名作為新的文件名
//     }
// });
// const upload = multer({ storage: storage });
// function getRelativePath(absolutePath) {
//     console.log("Absolute Path:", absolutePath);
//     let relativePath = path.relative(path.join(__dirname, '..', 'public'), absolutePath);
//     console.log("Generated Relative Path:", relativePath);
//     return relativePath.replace(/\\/g, '/');
// }

// const dbQuery = (query, values) => {
//     return new Promise((resolve, reject) => {
//         db.query(query, values, (error, results) => {
//             if (error) {
//                 reject(error);
//             } else {
//                 resolve(results);
//             }
//         });
//     });
// };

// router.post('/createProduct', upload.array('productImage', 5), (req, res, next) => {


//     next();
// }, async (req, res) => {

//     if (!req.body || !req.files || req.files.length === 0) {
//         return res.status(400).json({ message: '請求數據不完整' });
//     }
//     const mainImageIdx = Number(req.body.mainImageIdx);
//     const { productData: productInfo, productData: { cpu, gpu, ram, os, screen, battery, warranty, size, weight } } = req.body;

//     const productData = {
//         user_id: req.body.productData.user_id,
//         prod_name: req.body.productData.prod_name,
//         brand_id: req.body.productData.brand_id,
//         category_id: req.body.productData.category_id,
//         transport: req.body.productData.transport,
//         payment: req.body.productData.payment,
//     };
//     try {

//         const results = await dbQuery('INSERT INTO product SET ?', productData);
//         const prodId = results.insertId;
//         let imagesData = req.files.map((file, idx) => {
//             let relativePath;
//             if (file.path) {
//                 relativePath = getRelativePath(file.path);
//             }
//             return {
//                 prod_id: prodId,
//                 originalname: file.originalname,
//                 stored_name: file.filename,
//                 upload_date: new Date(),
//                 file_size: file.size,
//                 mime_type: file.mimetype,
//                 img_src: relativePath,
//                 products_info: mainImageIdx === idx ? 1 : 0
//             };
//         });

//         const imgInsertPromises = imagesData.map(imgData => {
//             return dbQuery('INSERT INTO product_images_test SET ?', imgData);
//         });

//         await Promise.all(imgInsertPromises);
//         res.json({ success: true, message: 'Product and images added successfully!' });
//         const price = req.body.productData.price;
//         const description = req.body.productData.description;
//         const spec = req.body.productData.spec;
//         const sellSpecData = {
//             prod_id: prodId,
//             spec_id: '10',
//             spec_name: spec,
//             contnet: description,
//             price: price,
//             cpu,
//             gpu,
//             ram,
//             os,
//             screen,
//             battery,
//             warranty,
//             size,
//             weight
//         };
//         await dbQuery('INSERT INTO sellspec SET ?', sellSpecData);

//     } catch (error) {
//         console.error("Error:", error);

//         if (error.code === 'ER_DUP_ENTRY') {
//             res.status(400).json({ success: false, message: 'Duplicate entry detected!' });
//         } else {
//             res.status(500).json({ success: false, message: 'Server error.' });
//         }
//     }

//     console.log('Complete req.body:', req.body);
// });



// module.exports = router;



