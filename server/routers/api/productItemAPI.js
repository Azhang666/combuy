const express = require("express");
const cpp = require("../../controllers/productPage/ctrlPorductPage.js");

const router = express.Router();

router.use(express.static(__dirname + "/public"));
//product page
router.get("/", (req, res) => {
  cpp.ctrlProdPage(req, res);
});

module.exports = router;
