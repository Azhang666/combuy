$(document).ready(function () {
  //change header navber sun and moon
  $(".slider").on("click ", function () {
    if ($(this).hasClass("sun")) {
      $(".sun").css({
        display: "none",
      });
      $(".moon").css({
        display: "block",
      });
    } else {
      $(".sun").css({
        display: "block",
      });
      $(".moon").css({
        display: "none",
      });
    }
  });
  $(document).ready(function () {
    $("#mode").on("change", function (e) {
      $.get("/api/userSetting/darkMode");
    });
  });
  //top-screen-button
  function blkTopScrBtn(elem) {
    if (
      document.body.scrollTop > 20 ||
      document.documentElement.scrollTop > 20 ||
      elem > 20
    ) {
      $("#topScreenBtn").css("display", "block");
    } else {
      $("#topScreenBtn").css("display", "none");
    }
  }
  function screenTop() {
    let [productScreen, elem] = document.getElementsByClassName("info");
    document.body.scrollTop = 0;
    document.documentElement.scrollTop = 0;
    productScreen.scrollTop = 0;
  }
  $(".info").on("scroll", function (e) {
    blkTopScrBtn(this.scrollTop);
  });
  $(window).on("scroll", function () {
    blkTopScrBtn();
  });
  $("#topScreenBtn").click(function () {
    screenTop();
  });
  //req herder select & herder select display block
  $('input[name="search"]').on("keyup", function () {
    //herder select display block
    $("#search-result").css("display", "block");
    //req herder select
    $.ajax({
      type: "get",
      url: "/api/changeProduct/search",
      data: {
        search: $(this).val(),
      },
      success: async function (response) {
        let result = ``;
        response.forEach((prod) => {
          result += `<li><a href="/commodity/${prod.prod_id}/${prod.spec_id}">${prod.prod_name}</a></li>`;
        });

        result == ""
          ? (result = "<li><p>搜尋無結果</p></li>")
          : (result = result);
        $("#search-result>ul").html(result);
      },
    });
  });
  $("body").on("click", function () {
    $("#search-result").css("display", "none");
  });
  //req brand product
  $(".brand>a").on("click", function () {
    $.ajax({
      type: "get",
      url: "/api/changeProduct",
      data: {
        brand: $(this).attr("value"),
      },
      success: async function (response) {
        await $(".productBox").remove();
        await $(".contral-product-page").remove();
        await $(".productSlecet").after(`${response}`);
      },
    });
  });
  //req addTime product & addTime product button change img
  let addTimeIsClick = 1;
  $("#addTime").click(function () {
    //addTime product button change img
    if ($(this).children("img").attr("alt") === "chevron-down") {
      $(this).children("img").attr({
        src: "/public/images/icons/chevron-up.svg",
        alt: "chevron-up",
      });
    } else {
      $(this).children("img").attr({
        src: "/public/images/icons/chevron-down.svg",
        alt: "chevron-down",
      });
    }
    //req addTime product
    $.ajax({
      type: "get",
      url: "/api/changeProduct",
      data: {
        getUpdateTime: addTimeIsClick,
      },
      success: async function (response) {
        await $(".productBox").remove();
        await $(".contral-product-page").remove();
        await $(".productSlecet").after(`${response}`);
        addTimeIsClick > 0 ? addTimeIsClick-- : addTimeIsClick++;
      },
    });
  });
  //req PriceDesc product & PriceDesc product button change img
  let priceDescIsClick = 1;
  $("#priceDesc").click(function () {
    //PriceDesc product button change img
    if ($(this).children("img").attr("alt") === "chevron-down") {
      $(this).children("img").attr({
        src: "/public/images/icons/chevron-up.svg",
        alt: "chevron-up",
      });
    } else {
      $(this).children("img").attr({
        src: "/public/images/icons/chevron-down.svg",
        alt: "chevron-down",
      });
    }
    //req PriceDesc product
    $.ajax({
      type: "get",
      url: "/api/changeProduct",
      data: {
        getPriceDesc: priceDescIsClick,
      },
      success: async function (response) {
        await $(".productBox").remove();
        await $(".contral-product-page").remove();
        await $(".productSlecet").after(`${response}`);
        priceDescIsClick > 0 ? priceDescIsClick-- : priceDescIsClick++;
      },
    });
  });
  //req PriceRange product
  $("input[pattern='[0-9]{7}']").on("keypress", function (e) {
    if (e.keyCode < 48 || e.keyCode > 57) {
      e.preventDefault();
    }
  });
  $("input[pattern='[0-9]{7}']").keyup(function () {
    $.ajax({
      type: "get",
      url: "/api/changeProduct",
      data: {
        getPriceRange: {
          form: $("input[name='priceFrom']").val()
            ? $("input[name='priceFrom']").val()
            : 0,
          to: $("input[name='priceTo']").val()
            ? $("input[name='priceTo']").val()
            : 0,
        },
      },
      success: async function (response) {
        await $(".productBox").remove();
        await $(".contral-product-page").remove();
        await $(".productSlecet").after(`${response}`);
      },
    });
  });
  //req productItemPage & ctrl product page css
  $("body").on("click", ".changePage", async function () {
    //ctrl product page css
    $(".contral-product-page>button").removeClass("active");
    $(this).addClass("active");
    //req productItemPage
    $.ajax({
      type: "get",
      url: "/api/changeProduct",
      data: {
        prodItemPage: $(this).text(),
      },
      success: async function (response) {
        await $(".productBox").remove();
        await $(".productSlecet").after(`${response}`);
      },
    });
  });
  //req productSelecet tag
  $("select[name='selectItem']").on("change", async function () {
    await $.ajax({
      type: "get",
      url: "/api/changeProduct",
      data: {
        prodSelTag: $(this).val(),
      },
      success: async function (response) {
        await $(".productBox").remove();
        await $(".contral-product-page").remove();
        await $(".productSlecet").after(`${response}`);
      },
    });
  });
  //req product comparison
  $(".prodComparison").on("click", async function () {
    await $.ajax({
      type: "get",
      url: "/api/changeProduct/prodComparison",
      data: {
        prod_id: $(this).data("prod_id"),
        spec_id: $(this).data("spec_id"),
      },
      success: function (response) {
        let arrTemp = [];
        let objTemp = {
          pId: response[0].prod_id,
          sId: response[0].spec_id,
          pName: response[0].prod_name,
          sName: response[0].spec_name,
          brand: response[0].brand,
          cpu: response[0].cpu,
          gpu: response[0].gpu,
          ram: response[0].ram,
          os: response[0].os,
          screen: response[0].screen,
          battery: response[0].battery,
          size: response[0].size,
          weight: response[0].weight,
          warranty: response[0].warranty,
          imgSrc: response[0].dir + response[0].filename,
        };
        if (!localStorage.getItem("product")) {
          localStorage.setItem("product", JSON.stringify(objTemp));
        } else {
          if (Array.isArray(JSON.parse(localStorage.getItem("product")))) {
            arrTemp = JSON.parse(localStorage.getItem("product"));
            if (arrTemp.length == 3) {
              arrTemp.shift();
            }
          } else {
            arrTemp.push(JSON.parse(localStorage.getItem("product")));
          }
          arrTemp.push(objTemp);
          localStorage.setItem("product", JSON.stringify(arrTemp));
        }
        //display btn
        $("#watchComparison").css("display", "block");
      },
      error: function (error) {
        alert(error);
      },
    });
  });
  //comparison btn

  //api/changeProductItem and this button prevent bubble events防止泡沫事件
  $("body").on("click", ".prodToPItem", function (e) {
    e.stopPropagation();
  });
  $("body").on("click", ".ctrlBtn", function (e) {
    e.preventDefault();
    e.stopPropagation();
  });
  let user_id = $("#userId").data("userId");
  //plusProduct
  $(".plusProd").on("click", async function () {
    if (user_id == "") {
      location.replace("http://localhost:2407/login");
    } else {
      await $.ajax({
        type: "post",
        url: "/commodity/addcart",
        data: {
          user_id: user_id,
          prod_id: $(this).data("prod_id"),
          spec_id: $(this).data("spec_id"),
        },
        success: function (response) {
          alert("此商品已加入購物車");
        },
        error: function (error) {
          alert("此商品已在購物車");
        },
      });
    }
  });
  //collectProduct
  $(".collectProd").on("click", async function () {
    if (user_id == "") {
      location.replace("http://localhost:2407/login");
    } else {
      await $.ajax({
        type: "post",
        url: "/commodity/addcollect",
        data: {
          user_id: user_id,
          prod_id: $(this).data("prod_id"),
          spec_id: $(this).data("spec_id"),
        },
        success: function (response) {
          alert("此商品已加入購物車");
        },
        error: function (error) {
          alert("此商品已在購物車");
        },
      });
    }
  });
  //jq ready bottom
});
