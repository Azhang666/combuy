const express = require('express');
const app = express();
const path = require('path');
const bodyParser = require('body-parser');
const cors = require('cors');

// 模組引入

const brandRoutes = require('./routes/brandRoutes');
const categoryRoutes = require('./routes/categoryRoutes');
const productRoutes = require('./routes/productRoutes');

// 中間件設定
app.use(cors());
app.use(bodyParser.json());
app.use(express.static(path.join(__dirname, 'public')));

// 路由設定

app.use('/', brandRoutes);
app.use('/', categoryRoutes);
app.use('/', productRoutes);

// 全域錯誤處理
app.use((err, req, res, next) => {
    console.error(err.stack);
    res.status(500).send('Something broke!');
});

const PORT = 2407;
app.listen(PORT, () => {
    console.log(`伺服器啟動中 ${PORT} ${new Date().toLocaleTimeString()}`);
    console.log('------------------------------------');
});
