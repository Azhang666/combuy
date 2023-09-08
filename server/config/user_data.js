class MemberData {
  constructor(u_id, u_name, right, islog = true) {
    this.u_id = u_id
    this.u_name = u_name
    this.right = right
    this.islog = islog
  }
}
class ComparisonList {
  constructor(prod_id, spec_id) {
    this.compares.push({ prod_id: prod_id, spec_id: spec_id })
  }
  addCompare(prod_id, spec_id) {
    this.compares.push({ prod_id: prod_id, spec_id: spec_id })
  }
}
module.exports = {
  MemberData,
  ComparisonList,
}
