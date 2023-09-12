const express = require("express");
const session = require("express-session");
const ejs = require("ejs");

const {
  login_render,
  login_api,
  notlogin_render,
  notlogin_api,
} = require("./middlewares/isLogin");

const app = express();

const setProt = 2407;

app.set("view engine", "ejs");

let ejsOptions = {
  // delimiter: '?', Adding this to tell you do NOT use this like I've seen in other docs, does not work for Express 4
  async: true,
};
// The engine is using a callback method for async rendering
app.engine("ejs", async (path, data, cb) => {
  try {
    let html = await ejs.renderFile(path, data, ejsOptions);
    cb(null, html);
  } catch (e) {
    cb(e, "");
  }
});

app.use(
  session({
    secret: "combuy",
    resave: true,
    saveUninitialized: true,
    cookie: {
      path: "/",
      httpOnly: true,
      secure: false,
      maxAge: 10 * 60 * 1000,
    },
  })
);

app.use("/public", express.static(__dirname + "/public"));

const fontPage = require("./routers/fontPage/fontPage.js");
app.use("/fontPage", fontPage);

app.get("/", (req, res) => {
  res.redirect("/fontPage");
  // res.setHeader("Content-type", "text/html;charset=utf-8");
  // res.end("root");
});

const api = require("./routers/api");
app.use("/api", api);

const login = require("./routers/memberPage/login");
app.use("/login", login);

const register = require("./routers/memberPage/register");
app.use("/register", notlogin_render, register);

const member = require("./routers/memberPage/member");
app.use("/member", login_render, member);
// app.use('/member', member)

const product = require("./routers/productPage/productPage.js");
app.use("/product", product);

const commodity = require("./routers/commodityPage/commodityPage.js");
app.use("/commodity", commodity);

const shopCart = require("./routers/shopCartPage/shopCartPage.js");
app.use("/shopCart", shopCart);

// app.use(function (req, res) {
// res.end('Error 404 Page Not Found')
// res.redirect("/");
// });

app.listen(setProt, () => {
  console.log(
    `-----------------\nhttp://localhost:${setProt}/  |\nFile:${__filename} |\nTime:${new Date().toLocaleString()} |\n-----------------`
  );
});
