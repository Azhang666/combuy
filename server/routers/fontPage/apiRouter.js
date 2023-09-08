var express = require("express");
var router = express.Router();
var db = require("../../models/fontPage/db");

// 獲取熱銷商品
router.get("/getHotIndexProd", function (req, res) {
  var query = "SELECT * FROM vw_products_info WHERE sales >= 1 LIMIT 6";
  db.query(query, function (err, result) {
    if (err) {
      console.error(err);
      res.status(500).json({ error: "資料讀取失敗。" });
    } else {
      res.status(200).json(result);
    }
  });
});

// 獲取學生開學季商品
router.get("/getStudentIndexProd", function (req, res) {
  var query = "SELECT * FROM vw_products_info ORDER BY price LIMIT 3";
  db.query(query, function (err, result) {
    if (err) {
      console.error(err);
      res.status(500).json({ error: "資料讀取失敗。" });
    } else {
      res.status(200).json(result);
    }
  });
});

// 獲取電競機商品
router.get("/getGamingIndexProd", function (req, res) {
  var query = "SELECT * FROM vw_products_info ORDER BY price DESC LIMIT 3";
  db.query(query, function (err, result) {
    if (err) {
      console.error(err);
      res.status(500).json({ error: "資料讀取失敗。" });
    } else {
      res.status(200).json(result);
    }
  });
});

// 加入最愛
router.post("/postFavoriteProd", function (req, res) {
  var user_id = req.body.user_id;
  var prod_id = req.body.prod_id;
  var spec_id = req.body.spec_id;
  var query = "INSERT INTO collect (user_id,prod_id, spec_id)VALUES(?,?,?)";
  db.query(query, [user_id, prod_id, spec_id], function (err, result) {
    if (err) {
      console.error(err);
      res.status(500).json({ error: "資料讀取失敗。" });
    } else {
      res.status(200).json(result);
    }
  });
});

// 移除最愛
router.delete("/deleteFavoriteProd", function (req, res) {
  var user_id = req.body.user_id;
  var prod_id = req.body.prod_id;
  var spec_id = req.body.spec_id;
  var query =
    "DELETE FROM collect WHERE user_id = ? AND prod_id = ? AND spec_id = ?";
  db.query(query, [user_id, prod_id, spec_id], function (err, result) {
    if (err) {
      console.error(err);
      res.status(500).json({ error: "資料讀取失敗。" });
    } else {
      res.status(200).json(result);
    }
  });
});

module.exports = router;
