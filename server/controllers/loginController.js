const LoginModel = require('../models/loginModel')

const LoginController = {
  loginSucRender: (req, res) => {
    res.render('member/message', {
      title: '會員登入',
      content: `${req.session.member.u_name}，歡迎登入`,
      btns: [
        { linkTo: '/', linkText: '前往首頁' },
        { linkTo: '/member', linkText: '會員中心' },
      ],
    })
  },
  loginAPI: async (req, res) => {
    const result = await LoginModel.loginAPI(req.body)
    if (result.err == 0) {
      req.session.member = result.data
    }
    console.log(req.session)
    res.end(JSON.stringify(result))
  },
  logoutAPI: (req, res) => {
    res.setHeader('Content-type', 'text/html;charset=utf-8')
    const result = LoginModel.logoutAPI(req.session.member)
    req.session.destroy()
    res.end(JSON.stringify(result))
  },
}
module.exports = LoginController