const db = require("../models/product/productData");

exports.productItem = (req, res) => {
  db.getBrandData([], (bdata) => {
    res.render("fontPage/fontPage", {
      brand: bdata,
    });
  });
};
