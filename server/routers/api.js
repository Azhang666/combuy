const express = require("express");
var router = express.Router();

const bodyparse = require("body-parser");

var bp_json = bodyparse.json({ limit: "10mb" });
var bp_uncode = bodyparse.urlencoded({ extended: true, limit: "10mb" });

const loginController = require("../controllers/loginController");

const {
  login_render,
  login_api,
  notlogin_render,
  notlogin_api,
} = require("../middlewares/isLogin");

router.get("/", function (req, res) {
  res.end("api root");
});

router.post("/login", bp_uncode, loginController.loginAPI);
router.get("/logout", login_api, loginController.logoutAPI);

const register = require("./api/register");
router.use("/register", bp_uncode, register);

const member = require("./api/member");
router.use("/member", login_api, bp_uncode, member);

const product = require("./api/productItemAPI");
router.use("/changeProduct", product);

module.exports = router;
