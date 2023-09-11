const express = require("express");
// var multer = require('multer')

var router = express.Router();

const MemberController = require("../../controllers/memberPage/memberController");

// var myStorage = multer.diskStorage({
//   destination: function (req, file, cb) {
//     cb(null, 'public/images/user')
//   },
//   filename: function (req, file, cb) {
//     cb(null, file.originalname + '_' + formatDateNow())
//   },
// })
// var multer_storage = multer({
//   storage: myStorage,
//   fileFilter: function (req, file, cb) {
//     if (file.mimetype.includes('image') <= 0) {
//       var error = new Error('錯誤格式的圖片。')
//       error.statusCode = 403
//       cb(error)
//     } else {
//       cb(null, true)
//     }
//   },
// })
// router.post('/')

// 會員資料更新
router.post("/dataUpdate", MemberController.dataUpdateAPI);
// 密碼更新
router.put("/pwdChange", MemberController.pwdChangeAPI);
// 卡片資料
router.post("/addCard", MemberController.addCradAPI);
router.put("/editCard", MemberController.editCardAPI);
router.delete("/deleteCard", MemberController.deleteCardAPI);
// 收藏、取消收藏
router.post("/collectProd", MemberController.collectProdAPI);
// 評論
router.patch("/commentUpdate", MemberController.commentUpdateAPI);

module.exports = router;
