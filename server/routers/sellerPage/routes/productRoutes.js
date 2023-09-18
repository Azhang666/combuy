const express = require('express');
const router = express.Router();
const productController = require('./productController');

router.get('/products', productController.getProducts);
router.get('/image',productController.getImage);
router.get('/downproducts', productController.getDownProducts);
router.put('/down/:productId', productController.updateProduct);
router.post('/createProduct', productController.createProduct);
router.get('/getProductsAllData/:prod_id',productController.getProductsAllData);
router.patch('/updateProductPartially/:prod_id', productController.partiallyUpdateProduct);

module.exports = router;
