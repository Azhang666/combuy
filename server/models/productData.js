const mysql = require("mysql");

exports.getBrandData = (setCondition, callBackData) => {
  var connection = mysql.createConnection({
    host: "localhost",
    port: 3307,
    user: "root",
    password: "",
    database: "combuy",
    multipleStatements: true,
  });
  connection.connect((err) => {
    if (err) {
      console.log("sql syntax error");
      console.log(err);
    }
  });
  connection.query("SELECT brand_id,brand FROM brand", (err, data) => {
    if (err) {
      console.log(err);
    } else {
      callBackData(data);
    }
  });
  connection.end();
};
// sqlDB.getBrandData([], (data) => {
//   console.log(data);
// });
exports.getprodItemData = (setCondition, callBackData) => {
  var connection = mysql.createConnection({
    host: "localhost",
    port: 3307,
    user: "root",
    password: "",
    database: "combuy",
    multipleStatements: true,
  });
  connection.connect((err) => {
    if (err) {
      console.log("sql syntax error");
      console.log(err);
    }
  });
  let filter = setCondition[5];
  setCondition.pop();
  connection.query(
    `SELECT prod_name,spec_name,price,img_src FROM vw_products_info
        WHERE brand_id=? AND price BETWEEN ? AND ?
        ${filter}
        LIMIT ?,?;`,
    setCondition,
    (err, data) => {
      if (err) {
        console.log(err);
      } else {
        callBackData(data);
      }
    }
  );
  connection.end();
};
// sqlDB.getprodItemData(
//   [
//     getBrand,
//     getPriceRange.form,
//     getPriceRange.to,
//     filter,
//     offset,
//     productItem,
//   ],
//   (data) => {
//     console.log(data);
//   }
// );
exports.getAllProdItemNumData = (setCondition, callBackData) => {
  const connection = mysql.createConnection({
    host: "localhost",
    port: 3307,
    user: "root",
    password: "",
    database: "combuy",
    multipleStatements: true,
  });
  connection.connect((err) => {
    if (err) {
      console.log("sql syntax error");
      console.log(err);
    }
  });
  connection.query(
    `SELECT COUNT(*) as productTotal FROM vw_products_info
        WHERE brand_id=? AND price BETWEEN ? AND ?`,
    setCondition,
    (err, data) => {
      if (err) {
        console.log(err);
      } else {
        callBackData(data);
      }
    }
  );
  connection.end();
};
// sqlDB.getAllProdItemNumData(
//   [getBrand, getPriceRange.form, getPriceRange.to],
//   (data) => {
//     console.log(data);
//   }
// );
exports.getTagprodItemData = (setCondition, callBackData) => {
  var connection = mysql.createConnection({
    host: "localhost",
    port: 3307,
    user: "root",
    password: "",
    database: "combuy",
    multipleStatements: true,
  });
  connection.connect((err) => {
    if (err) {
      console.log("sql syntax error");
      console.log(err);
    }
  });
  let filter = setCondition[5];
  setCondition.pop();
  connection.query(
    `SELECT prod_name,spec_name,price, img_src FROM product_tag 
    LEFT join vw_products_info ON product_tag.prod_id = vw_products_info.prod_id
    WHERE product_tag.tag=? AND vw_products_info.price BETWEEN ? AND ?
   ${filter}
    LIMIT ?,?`,
    setCondition,
    (err, data) => {
      if (err) {
        console.log(err);
      } else {
        callBackData(data);
      }
    }
  );
  connection.end();
};
// sqlDB.getTagprodItemData(
//   [
//     prodSelTag,
//     getPriceRange.form,
//     getPriceRange.to,
//     filter,
//     offset,
//     productItem,
//   ],
//   (data) => {
//     console.log(data);
//   }
// );
exports.getAllTagProdItemNumData = (setCondition, callBackData) => {
  var connection = mysql.createConnection({
    host: "localhost",
    port: 3307,
    user: "root",
    password: "",
    database: "combuy",
    multipleStatements: true,
  });
  connection.connect((err) => {
    if (err) {
      console.log("sql syntax error");
      console.log(err);
    }
  });
  connection.query(
    `SELECT COUNT(*) as productTagTotal FROM product_tag 
                RIGHT JOIN tag on tag.tag =product_tag.tag
                RIGHT JOIN product on product.prod_id =product_tag.prod_id
                LEFT JOIN sellspec on sellspec.prod_id  = product.prod_id
                RIGHT JOIN productimg on productimg.prod_id =product.prod_id AND sellspec.spec_id=productimg.spec_id AND productimg.type=0
                WHERE tag.tag=? AND price BETWEEN ? AND ?`,
    setCondition,
    (err, data) => {
      if (err) {
        console.log(err);
      } else {
        callBackData(data);
      }
    }
  );
  connection.end();
};
// sqlDB.getAllTagProdItemNumData(
//   [prodSelTag, getPriceRange.form, getPriceRange.to],
//   (data) => {
//     console.log(data);
//   }
// );
