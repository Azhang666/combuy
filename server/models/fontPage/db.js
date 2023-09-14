var mysql = require('mysql')

var db = mysql.createPool({
  host: 'localhost',
  user: 'root',
  password: 'root',
  port: '3306',
  database: 'combuy',
})
// 3.測試 mysql模組 能否正常工作
// 'SELECT 1' 是測試語句, 用來測試能否正常運作
// 只要能在console 看到代表能夠正常運作
db.query('SELECT 1', function (err, result) {
  // 這是 mysql 工作期間報錯的語句
  if (err) return console.log(err.message)
  // 這是能夠正常運作的語句
  //   console.log(result);
})
module.exports = db
