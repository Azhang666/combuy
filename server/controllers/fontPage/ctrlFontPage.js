const db = require("../../models/productPage/productData");

exports.fontPage = (req, res) => {
  
  db.getBrandData([], (bdata) => {
    res.render("fontPage/fontPage", {
      brand: bdata,
    });
  });
};
