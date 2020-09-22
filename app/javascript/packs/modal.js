$(function () {
  $(".buy-modal-open").on("click", function () {
    $(".buy-modal").fadeIn();
    return false;
  });
  $(".sell-modal-open").on("click", function () {
    $(".sell-modal").fadeIn();
    return false;
  });
  $(".modal-close").on("click", function () {
    $(".buy-modal").fadeOut();
    $(".sell-modal").fadeOut();
    return false;
  });
  $("#buy_amount_input").on("input", function () {
    $("#buy_total_amount").text(
      $("#buy_amount_input").val() * gon.player.buy_price
    );
  });
  $("#sell_amount_input").on("input", function () {
    $("#sell_total_amount").text(
      $("#sell_amount_input").val() * gon.player.sell_price
    );
  });
});
