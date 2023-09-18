const express = require("express");
const cpp = require("../../controllers/productPage/ctrlPorductPage.js");
const router = express.Router();

//product page
router.get("/:brand", cpp.ctrlProdPage);

router.get("/watchComparison", (req, res) => {
  res.render("product/watchComparison.ejs");
});

module.exports = router;
