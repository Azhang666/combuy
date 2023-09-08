const db = require("../models/productPage/productData");

exports.productItem = (req, res) => {
  db.getBrandData([], (bdata) => {
    res.render("fontPage/fontPage", {
      brand: bdata,
    });
  });
};
