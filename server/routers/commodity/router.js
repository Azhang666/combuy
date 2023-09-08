var express = require('express');
var router = express.Router();
var mysql = require('mysql');
var ejs = require('ejs');
var db = require('./db');



var conn = mysql.createConnection({
    // ... your connection configuration ...
    host: 'localhost',
    user: 'root',
    password: 'root',
    database: 'combuy',
    port: '3306'
});

// 定義路由處理程式
router.get('/product/:prod_id', async (req, res) => {
    try {
        var prodId = 9; // 這裡預設為 1，你可以根據需要更改
        var specId = 1;
        var brandId = 2;
        var productData = {};

        var data = await queryDatabase('SELECT * FROM sellspec WHERE prod_id = ? AND spec_id = ?', [prodId, specId, brandId]);
        var imageDataT0 = await queryDatabase('SELECT * FROM productimg WHERE prod_id = ? AND type = 0', [prodId]);
        var imageDataT1 = await queryDatabase('SELECT * FROM productimg WHERE prod_id = ? AND type = 1', [prodId]);
        var nameData = await queryDatabase('SELECT prod_name FROM product WHERE prod_id = ?', [prodId]);
        var brandData = await queryDatabase('SELECT brand FROM brand WHERE brand_id = ?', [brandId]);
        var priceData = await queryDatabase('SELECT price FROM sellspec WHERE prod_id = ?', [prodId]);
        var totalCountData = await queryDatabase('SELECT COUNT(*) AS COUNT FROM productimg');
        var totalCount = totalCountData[0].COUNT;
        var relatedProducts = await queryDatabase('SELECT * FROM productimg WHERE type = 0');
        var commentData = await queryDatabase('SELECT count, comment, comment_grade, comment_time FROM order_product WHERE prod_id = ?', [prodId]);
        commentData.forEach(comment => {
            comment.comment_time = new Date(comment.comment_time).toLocaleString();
        });

        // 使用 Promise.all 處理所有資料庫的查詢
        await Promise.all(relatedProducts.map(async (product) => {
            var prodId = product.prod_id;
            var specId = product.spec_id;

            var productNameData = await queryDatabase('SELECT prod_name FROM product WHERE prod_id = ?', [prodId]);
            var productPriceData = await queryDatabase('SELECT price FROM sellspec WHERE prod_id = ?', [prodId]);
            var productSpecname = await queryDatabase('SELECT spec_name FROM sellspec WHERE prod_id =? AND spec_id = ?', [prodId, specId]);

            productData[prodId] = {
                prod_name: productNameData[0].prod_name,
                price: productPriceData[0].price,
                spec_name: productSpecname[0].spec_name
            };
        }));

        res.render('index', {
            data,
            imageDataT0: imageDataT0[0],
            imageDataT1: imageDataT1[0],
            nameData,
            brandData,
            priceData,
            attributes: ['spec_name', 'content', 'price', 'stock', 'cpu', 'gpu', 'ram', 'os', 'screen', 'warranty', 'size', 'battery', 'weight'],
            totalCount: totalCount,
            relatedProducts: relatedProducts.map((product) => ({
                ...product,
                ...productData[product.prod_id]
            })),
            commentData,
            prodId,
            specId
        });

    } catch (err) {
        console.error('Error:', err);
        res.status(500).send('Internal Server Error');
    }
});

// 獲取分頁資料
// '/數字' 變數代稱 透過正規表達式檢查
// router.get('/product/:prod_id', function (req, res) {
//     var page = req.params.page
//     if (page <= 0) {
//         res.redirect('/1')
//         return
//     }
//     //每頁資料數
//     var nums_per_page = 4;
//     //定義資料偏移量
//     var offset = (page - 1) * nums_per_page

//     db.exec(`SELECT * FROM productimg LIMIT ${offset}, ${nums_per_page};`, [], function (data, fields) {
//         // 在这里，您不需要重新计算总记录数，只需使用从根路径传递的 totalCount 数据
//         var totalCount = res.locals.totalCount; // 从 res.locals 中获取总记录数

//         var last_page = Math.ceil(totalCount / nums_per_page)
//         if (page > last_page) {
//             res.redirect('/' + last_page)
//             return
//         }

//         res.render('index', {
//             data: data,
//             curr_page: page,
//             total_nums: totalCount, // 使用从根路径传递的总记录数
//             last_page: last_page
//         })
//     })
// })


// 加入購物車
router.post('/addcart', async (req, res) => {
    try {
        var { user_id, prod_id, spec_id } = req.body;
        var spl = 'INSERT INTO shopcart (user_id, prod_id, spec_id) VALUES (?, ?, ?)';
        await queryDatabase(spl, [user_id, prod_id, spec_id]);

        res.status(200).send('成功加入購物車');
    } catch (error) {
        console.error('加入購物車失敗', error);
        res.status(500).send('內部伺服器錯誤');
    }
});

// 加入收藏
router.post('/addcollect', async (req, res) => {
    try {
        var { user_id, prod_id, spec_id, update_time } = req.body;
        var sql = 'INSERT INTO collect (user_id, prod_id, spec_id) VALUES (?, ?, ?)';
        await queryDatabase(sql, [user_id, prod_id, spec_id]);
        res.status(200).send('成功加入收藏');
    } catch (error) {
        console.error('加入收藏失敗', error);
        res.status(500).send('內部伺服器錯誤');
    }
});

// 相關商品
// router.get('/product/:prod_id', async (req, res) => {
//     try {
//         const prodId = req.params.prod_id;
//         const productData = await queryDatabase('SELECT * FROM product WHERE prod_id = ?', [prodId]);

//         if (productData.length === 0) {
//             res.status(404).send('Product not found');
//         } else {
//             var imageDataT0 = productData[0]
//             res.render('index', { productData, imageDataT0 });
//         }
//     } catch (err) {
//         console.error('Error:', err);
//         res.status(500).send('Internal Server Error');
//     }
// });



// 封裝資料庫查詢為 Promise
function queryDatabase(sql, params) {
    return new Promise((resolve, reject) => {
        conn.query(sql, params, (err, results) => {
            if (err) {
                reject(err);
            } else {
                resolve(results);
            }
        });
    });
}


module.exports = router;
