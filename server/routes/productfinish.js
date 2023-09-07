const express = require("express");

const sqlDB = require("../module/sqlData.js");
const db = require("../module/productData.js");

const router = express.Router();

router.use(express.static(__dirname + "/public"));

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
router.get("/", (req, res) => {
  let randerProdItme = false;
  //ctrl req brand
  if (req.query.brand) {
    getBrand = req.query.brand;
    randerProdTag = false;
  }
  //ctrl req getUpdateTime & desc
  if (setDESC && filter.includes("update_time")) {
    filter = `ORDER BY update_time DESC`;
    setDESC = false;
  } else if (setDESC && filter.includes("price")) {
    filter = `ORDER BY price DESC`;
    setDESC = false;
  } else if (Number(req.query.getUpdateTime)) {
    filter = `ORDER BY update_time`;
    setDESC = true;
  } else if (Number(req.query.getPriceDesc)) {
    filter = `ORDER BY price`;
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
  //tag can not use ORDER BY
  if (randerProdTag && req.query.getUpdateTime) {
    filter = `ORDER BY ""`;
  }
  //module db
  //brand
  sqlDB.db("SELECT brand_id,brand FROM brand", [], (brandData) => {
    //product
    sqlDB.db(
      `SELECT prod_name,spec_name,price,img_src FROM vw_products_info
      WHERE brand_id=? AND price BETWEEN ? AND ?
      ${filter}
      LIMIT ?,?;`,
      [getBrand, getPriceRange.form, getPriceRange.to, offset, productItem],
      (productData) => {
        //productItem total (Number)
        sqlDB.db(
          `SELECT COUNT(*) as productTotal FROM vw_products_info
      WHERE brand_id=? AND price BETWEEN ? AND ?`,
          [getBrand, getPriceRange.form, getPriceRange.to],
          (productTotalData) => {
            sqlDB.db(
              `SELECT prod_name,spec_name,price,concat(dir,filename)as img_src FROM product_tag 
              RIGHT JOIN tag on tag.tag =product_tag.tag
              RIGHT JOIN product on product.prod_id =product_tag.prod_id
              LEFT JOIN sellspec on sellspec.prod_id  = product.prod_id
              RIGHT JOIN productimg on productimg.prod_id =product.prod_id AND sellspec.spec_id=productimg.spec_id AND productimg.type=0
              WHERE tag.tag=? AND price BETWEEN ? AND ?
              ${filter} 
              LIMIT ?,?`,
              [
                prodSelTag,
                getPriceRange.form,
                getPriceRange.to,
                offset,
                productItem,
              ],
              (productTagData) => {
                sqlDB.db(
                  `SELECT COUNT(*) as productTagTotal FROM product_tag 
              RIGHT JOIN tag on tag.tag =product_tag.tag
              RIGHT JOIN product on product.prod_id =product_tag.prod_id
              LEFT JOIN sellspec on sellspec.prod_id  = product.prod_id
              RIGHT JOIN productimg on productimg.prod_id =product.prod_id AND sellspec.spec_id=productimg.spec_id AND productimg.type=0
              WHERE tag.tag=? AND price BETWEEN ? AND ?`,
                  [prodSelTag, getPriceRange.form, getPriceRange.to],
                  async (productTagTotalData) => {
                    let lastPage = Math.ceil(
                      productTotalData[0].productTotal / productItem
                    );
                    let lastTagPage = Math.ceil(
                      productTagTotalData[0].productTagTotal / productItem
                    );
                    if (firstTime) {
                      res.render("productPage.ejs", {
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
});

//product comparison
router.get("/prodComparison", (req, res) => {
  console.log(req.query.product);
});

module.exports = router;
