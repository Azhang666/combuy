const express = require("express");
const cpp = require("../../controllers/productPage/changeProductItem");
const hsp = require("../../controllers/ctrlHdSelProd.js");

var router = express.Router();

router.get("/", (req, res) => {
  cpp.changeProduct(req, res);
  //res string
});

//product comparison
router.get("/prodComparison", (req, res) => {
  console.log(req.query.product);
});

//header select tool
router.get("/search", (req, res) => {
  hsp.herderSelProd(req, res);
});

module.exports = router;
