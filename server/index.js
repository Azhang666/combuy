const express = require("express");
const ejs = require("ejs");
const connection = require("./models/sqlData.js");
const product = require("./routers/product.js");
const app = express();

app.set("view engine", "ejs");

let setProt = 2407;
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

app.use(express.static(__dirname + "/public"));
app.use("/product", product);

app.get("/", (req, res) => {
  res.send("首頁");
});
//header select tool
app.get("/search", (req, res) => {
  let search = req.query.search;
  connection
    .sql()
    .queryAsync(
      `SELECT prod_name as prod FROM vw_products_info WHERE prod_name LIKE "${search}%"`
    )
    .then((data) => {
      res.send(data);
    });
});

app.listen(setProt, () => {
  console.log(`http://localhost:${setProt}/`);
});
