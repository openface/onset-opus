$(document).ready(function () {
  $("#attach_player").click(function (e) {
    CallEvent(
      "opus:AttachPlayer",
      $("#attach_modelid").val(),
      $("#attach_bone").val(),
      $("#attach_x").val(),
      $("#attach_y").val(),
      $("#attach_z").val(),
      $("#attach_rx").val(),
      $("#attach_ry").val(),
      $("#attach_rz").val(),
    );
  });
});
