const express = require("express");
const cpp = require("../../controllers/productPage/ctrlPorductPage.js");
const router = express.Router();

//product page
router.get("/", cpp.ctrlProdPage, (req, res) => {
  console.log(req.session.setting);
  res.render("productPage/productPage", {
    setting: req.session.setting,
  });
});

module.exports = router;
