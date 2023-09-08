// 非管理員使用 轉跳回首頁
const admin_render = function (req, res, next) {
  if (req.session.member) {
    if (req.session.member.right == 0) {
      return next()
    }
  }
  res.redirect('/')
}
// 非賣家使用 轉跳回首頁
const seller_render = function (req, res, next) {
  if (req.session.member) {
    if (req.session.member.right == 1) {
      return next()
    }
  }
  res.redirect('/')
}

// 非買家使用 轉跳回首頁
const buyer_render = function (req, res, next) {
  if (req.session.member) {
    if (req.session.member.right == 2) {
      return next()
    }
  }
  res.redirect('/')
}

module.exports = {
  admin_render,
  seller_render,
  buyer_render,
}
