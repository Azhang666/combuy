const express = require("express");
const cpp = require("../../controllers/product/ctrlPorductPage.js");

const router = express.Router();

router.use(express.static(__dirname + "/public"));
//product page
router.get("/", (req, res) => {
  cpp.ctrlProdPage(req, res);
});

//product comparison
router.get("/prodComparison", (req, res) => {
  console.log(req.query.product);
});

module.exports = router;
