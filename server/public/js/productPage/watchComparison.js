$(document).ready(function () {
  let data = JSON.parse(localStorage.getItem("product"));
  let temp = ``;
  console.log(data);
  for (let i = 0; i < data.length; i++) {
    temp += `<div class="col-3">產品名稱</div>
    <div class="row col-9">
    <div class="col-4">${data[i].pName}</div>
    <div class="col-4">${data[i].sName}</div>
    <div class="col-4">${data[i].brand}</div>
    </div>
    `;
  }
  $(".row").append(temp);
});
