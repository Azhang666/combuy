const mysql = require("mysql");
const db = require("../../../../config/config");
var connection = mysql.createConnection(db.db_setting);
connection.connect((err) => {
  if (err) {
    console.error("無法連接到資料庫:", err.stack);
    return;
  }

  // console.log("已成功連接到資料庫");
});

module.exports = connection;
