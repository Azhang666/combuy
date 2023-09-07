const mysql = require("mysql");
const bluebird = require("bluebird");
exports.sql = () => {
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
  return bluebird.promisifyAll(connection);
  // 因為 bluebird 的關係，牠會在原方法後面加上 Async
  //      => query  變成  queryAsync
  connection
    .queryAsync(sql1)
    // 因為 queryAsync() 回傳一個 promise ， 所以可以 .then()
    .then(function (data) {
      data = data;
      console.log(data[0].child_mask);
      // 等到第一個sql結果收到了
      // 繼續執行第二個sql
      //  => return 一個 promise，所以可以再次使用 .then()
      return myDBconn.queryAsync(sql2, [data[0].child_mask]);
    });
};
exports.db = (setSqlCom, setData, callBackData) => {
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
  connection.query(setSqlCom, setData, (err, data) => {
    // console.log(err);
    callBackData(data);
  });
};
