const db = require("../../models/productPage/productData.js");

//product init
let firstTime = true;
let getBrand = 2;
let filter = `ORDER BY ""`;
let setDESC = false;
let getPriceRange = {
  form: 0,
  to: 999999,
};
let prodItemPage = 1;
let productItem = 12;
let offset = (prodItemPage - 1) * productItem;
let prodSelTag = 3;
let randerProdTag = false;
exports.ctrlProdPage = (req, res) => {
  let randerProdItme = false;
  //ctrl req brand
  if (req.query.brand) {
    getBrand = req.query.brand;
    randerProdTag = false;
  }
  //ctrl req getUpdateTime & desc
  if (setDESC && filter.includes("update_time")) {
    filter = `ORDER BY vw_products_info.update_time DESC`;
    setDESC = false;
  } else if (setDESC && filter.includes("price")) {
    filter = `ORDER BY vw_products_info.price DESC`;
    setDESC = false;
  } else if (Number(req.query.getUpdateTime)) {
    filter = `ORDER BY vw_products_info.update_time`;
    setDESC = true;
  } else if (Number(req.query.getPriceDesc)) {
    filter = `ORDER BY vw_products_info.price`;
    setDESC = true;
  }
  //ctrl req PriceRange
  if (req.query.getPriceRange && !randerProdTag) {
    getPriceRange.form = req.query.getPriceRange.form;
    getPriceRange.to = req.query.getPriceRange.to;
  }
  if (getPriceRange.form == 0 && getPriceRange.to == 0) {
    getPriceRange.form = 0;
    getPriceRange.to = 999999;
  }
  //ctrl productItemPage
  if (req.query.prodItemPage) {
    prodItemPage = Number(req.query.prodItemPage);
    offset = (prodItemPage - 1) * productItem;
    randerProdItme = true;
  }
  //ctrl productTagItem
  if (req.query.prodSelTag) {
    prodSelTag = Number(req.query.prodSelTag);
    randerProdTag = true;
  }
  //module db
  //brand
  db.getBrandData([], (brandData) => {
    //product
    db.getprodItemData(
      [
        getBrand,
        getPriceRange.form,
        getPriceRange.to,
        offset,
        productItem,
        filter,
      ],
      (productData) => {
        //productItem total (Number)
        db.getAllProdItemNumData(
          [getBrand, getPriceRange.form, getPriceRange.to],
          (productTotalData) => {
            db.getTagprodItemData(
              [
                prodSelTag,
                getPriceRange.form,
                getPriceRange.to,
                offset,
                productItem,
                filter,
              ],
              (productTagData) => {
                db.getAllTagProdItemNumData(
                  [prodSelTag, getPriceRange.form, getPriceRange.to],
                  async (productTagTotalData) => {
                    let lastPage = Math.ceil(
                      productTotalData[0].productTotal / productItem
                    );
                    let lastTagPage = Math.ceil(
                      productTagTotalData[0].productTagTotal / productItem
                    );

                    if (firstTime) {
                      res.render("product/productPage.ejs", {
                        brand: brandData,
                        product: productData,
                        lastPage: lastPage,
                      });
                      firstTime = false;
                    } else if (randerProdTag && randerProdItme) {
                      return await res.render(
                        `chageProduct.ejs`,
                        {
                          product: productTagData,
                        },
                        (err, html) => standardResponse(err, html, res)
                      );
                    } else if (randerProdTag) {
                      return await res.render(
                        `chageProdAndPage.ejs`,
                        {
                          product: productTagData,
                          lastPage: lastTagPage,
                        },
                        (err, html) => standardResponse(err, html, res)
                      );
                    } else if (randerProdItme) {
                      return await res.render(
                        `chageProduct.ejs`,
                        {
                          product: productData,
                        },
                        (err, html) => standardResponse(err, html, res)
                      );
                    } else {
                      return await res.render(
                        `chageProdAndPage.ejs`,
                        {
                          product: productData,
                          lastPage: lastPage,
                        },
                        (err, html) => standardResponse(err, html, res)
                      );
                    }
                  }
                );
              }
            );
          }
        );
        const standardResponse = (err, html, res) => {
          // If error, return 500 page
          if (err) {
            console.log(err);
            // Passing null to the error response to avoid infinite loops XP
            return res
              .status(500)
              .render(`layout.ejs`, { page: "500", error: err }, (err, html) =>
                standardResponse(null, html, res)
              );
            // Otherwise return the html
          } else {
            return res.status(200).send(html);
          }
        };
      }
    );
  });
};
