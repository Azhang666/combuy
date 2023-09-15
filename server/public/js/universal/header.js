$(document).ready(function () {
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
});