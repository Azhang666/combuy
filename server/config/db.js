const mysql = require('mysql')
const bluebird = require('bluebird')

var conn = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'combuy',
  port: 3306,
})
conn.connect(function (err) {
  if (err) {
    return
  }
})
bluebird.promisifyAll(conn)
module.exports = conn
