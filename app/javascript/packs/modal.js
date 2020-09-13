$(function () {
  $(".modal-open").on("click", function () {
    $(".modal").fadeIn();
    return false;
  });
  $(".modal-close").on("click", function () {
    $(".modal").fadeOut();
    return false;
  });
});
