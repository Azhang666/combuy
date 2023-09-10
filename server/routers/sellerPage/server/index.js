const express = require('express');
const path = require('path');
const bodyParser = require('body-parser');
const cors = require('cors');

const db = require('../server/routes/database');  // 引入資料庫連接模組
const productRoutes = require('../server/routes/productRoutes');  // 引入路由模組

const app = express();
app.use(cors());
app.use(bodyParser.json());
app.use(express.static(path.join(__dirname, 'public')));




app.use('/', productRoutes);  // 使用路由模組

app.use((err, req, res, next) => {
    console.error(err.stack);
    res.status(500).send('Something broke!');
});

const PORT = 2407;
app.listen(PORT, () => {
    console.log(`伺服器啟動中 ${PORT} ${new Date().toLocaleTimeString()}`);
    console.log('------------------------------------');
    console.log('------------------------------------');
    console.log('------------------------------------');
    console.log('------------------------------------');
    
});
