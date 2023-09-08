const mysql = require("mysql");
const bluebird = require("bluebird");

var conn = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "",
  database: "combuy",
  port: 3307,
});
conn.connect(function (err) {
  if (err) {
    return;
  }
});
bluebird.promisifyAll(conn);
module.exports = conn;
//not blue bird

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
exports = connection;
