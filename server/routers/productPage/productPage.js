const express = require("express");
const cpp = require("../../controllers/productPage/ctrlPorductPage.js");
const router = express.Router();

//product page
router.get("/:brand", cpp.ctrlProdPage);

module.exports = router;
