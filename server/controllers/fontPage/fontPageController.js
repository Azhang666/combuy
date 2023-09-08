const db = require("../models/product/productData");

exports.fontPage = (req, res) => {
  db.getBrandData([], (bdata) => {
    res.render("fontPage/fontPage", {
      brand: bdata,
    });
  });
};
