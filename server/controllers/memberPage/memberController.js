const MemberModel = require('../../models/memberPage/memberModel')

const MemberController = {
  dataRender: async (req, res) => {
    const uid = req.session.member.u_id
    const result = await MemberModel.dataRender(uid)

    if (result.err == 0) {
      res.render('member/data', {
        title: '會員資料',
        setting: req.session.setting,
        right: req.session.member.right,
        type: 0,
        ...result.data,
      })
    } else {
      res.redirect('back')
    }
  },
  dataUpadteSucRender: (req, res) => {
    res.render('member/message', {
      title: '會員資料',
      setting: req.session.setting,
      content: `資料修改成功`,
      btns: [{ linkTo: '/member/data', linkText: '確 定' }],
    })
  },

  dataUpdateAPI: async (req, res) => {
    try {
      const uid = req.session.member.u_id
      var result = await MemberModel.dataUpdateAPI(uid, req.body)
      res.end(JSON.stringify(result))
    } catch (err) {
      throw err
    }
  },

  pwdChangeRender: async (req, res) => {
    res.render('member/pwdChange', {
      title: '修改密碼',
      setting: req.session.setting,
      right: req.session.member.right,
      type: 1,
    })
  },

  pwdChangeSucRender: (req, res) => {
    req.session.destroy()

    res.render('member/message', {
      title: '修改密碼',
      right: req.session.member.right,
      setting: req.session.setting,
      content: `密碼修改成功，請重新登入`,
      btns: [
        { linkTo: '/login', linkText: '重新登入' },
        { linkTo: '/', linkText: '前往首頁' },
      ],
    })
  },

  pwdChangeAPI: async (req, res) => {
    try {
      const uid = req.session.member.u_id
      const result = await MemberModel.pwdChangeAPI(uid, req.body)
      res.end(JSON.stringify(result))
    } catch (err) {
      throw err
    }
  },

  cardRender: async (req, res) => {
    const uid = req.session.member.u_id
    const result = await MemberModel.cardRender(uid)

    res.render('member/cards', {
      title: '付款設定',
      right: req.session.member.right,
      setting: req.session.setting,
      type: 2,
      ...result.data,
    })
  },

  addCradAPI: async (req, res) => {
    try {
      const uid = req.session.member.u_id
      const result = await MemberModel.addCradAPI(uid, req.body)
      res.end(JSON.stringify(result))
    } catch (err) {
      throw err
    }
  },
  editCardAPI: async (req, res) => {
    try {
      const uid = req.session.member.u_id
      const result = await MemberModel.editCardAPI(uid, req.body)
      res.end(JSON.stringify(result))
    } catch (err) {
      throw err
    }
  },
  deleteCardAPI: async (req, res) => {
    try {
      const uid = req.session.member.u_id

      const result = await MemberModel.deleteCardAPI(uid, req.body)
      res.end(JSON.stringify(result))
    } catch (err) {
      throw err
    }
  },

  orderlistRender: async (req, res) => {
    var page = req.params.page
    if (isNaN(page) || page <= 0) {
      res.redirect('/member/orderlist/1')
      return
    }
    const uid = req.session.member.u_id

    const result = await MemberModel.orderlistRender(uid, parseInt(page))

    if (page > result.data.max_pages) {
      res.redirect(`/member/orderlist/${result.data.max_pages}`)
      return
    }
    res.render('member/orderList', {
      title: '查看訂單',
      right: req.session.member.right,
      setting: req.session.setting,
      type: 3,
      page: page,
      ...result.data,
    })
  },

  orderRender: async (req, res) => {
    const uid = req.session.member.u_id
    var order_id = req.params.order_id
    const result = await MemberModel.orderRender(uid, order_id)

    if (result.err == 1) {
      res.redirect('/member/orderlist')
    } else {
      res.render('member/order', {
        title: '訂單資料',
        right: req.session.member.right,
        setting: req.session.setting,
        type: 3,
        ...result.data,
      })
    }
  },

  collectRender: async (req, res) => {
    const uid = req.session.member.u_id
    var page = req.params.page
    if (isNaN(page) || page <= 0) {
      res.redirect('/member/collect/1')
      return
    }
    const result = await MemberModel.collectRender(uid, parseInt(page))
    if (page > result.data.max_pages) {
      res.redirect(`/member/collect/${result.data.max_pages}`)
      return
    }
    res.render('member/collect', {
      title: '收藏商品',
      right: req.session.member.right,
      setting: req.session.setting,
      type: 4,
      page: page,
      ...result.data,
    })
  },
  collectProdAPI: async (req, res) => {
    try {
      const uid = req.session.member.u_id
      const result = await MemberModel.collectProdAPI(uid, req.body.prod_id, req.body.spec_id)

      res.end(JSON.stringify(result))
    } catch (err) {
      throw err
    }
  },

  commentRender: async (req, res) => {
    const uid = req.session.member.u_id
    let page = req.params.page
    if (isNaN(page) || page <= 0) {
      res.redirect('/member/comment/1')
      return
    }
    const result = await MemberModel.commentRender(uid, parseInt(page))
    if (page > result.data.max_pages) {
      res.redirect(`/member/comment/${result.data.max_pages}`)
      return
    }
    res.render('member/comment', {
      title: '留言紀錄',
      right: req.session.member.right,
      setting: req.session.setting,
      type: 5,
      page: page,
      ...result.data,
    })
  },
  commentEditRender: async (req, res) => {
    const uid = req.session.member.u_id
    const order_id = req.params.order_id || ''
    const prod_id = req.params.prod_id || ''
    const spec_id = req.params.spec_id || ''

    const result = await MemberModel.commentEditRender(uid, order_id, prod_id, spec_id)

    if (result.data.total == 0) {
      res.redirect('/member/comment')
    } else {
      res.render('member/commentEdit', {
        title: '留言紀錄',
        right: req.session.member.right,
        setting: req.session.setting,
        type: 5,
        ...result.data,
      })
      // res.setHeader('Content-type', 'text/html;charset=utf-8')
      // res.end(JSON.stringify(result))
    }
  },
  commentUpdateAPI: async (req, res) => {
    const uid = req.session.member.u_id
    try {
      const result = await MemberModel.commentUpdateAPI(uid, req.body)
      res.end(JSON.stringify(result))
    } catch (err) {
      throw err
    }
  },
}
module.exports = MemberController

// res.setHeader('Content-type', 'text/html;charset=utf-8')
// res.end(JSON.stringify(result))
