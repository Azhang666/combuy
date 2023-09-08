const express = require("express");

const prodItem = require("../../controllers/productItem");
const fontPage = require("../../controllers/fontPage/fontPageController");

const router = express.Router();

//font page
router.get("/", (req, res) => {
  fontPage.fontPage(req, res);
});

router.get("/prod", (req, res) => {
  prodItem.productItem(req, res);
});

router.get("/product", (req, res) => {});

module.exports = router;
