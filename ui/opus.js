$(document).ready(function () {
  // attach object to player
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
      $("#attach_rz").val()
    );
  });
  // detach object from player
  $("#destroy_attachment").click(function (e) {
    CallEvent("opus:DestroyAttachment");
  });
  // add component to attach object
  $("#add_light").click(function (e) {
    CallEvent(
      "opus:AddComponent",
      $("#light_x").val(),
      $("#light_y").val(),
      $("#light_z").val(),
      $("#light_rx").val(),
      $("#light_ry").val(),
      $("#light_rz").val()
    );
  });
});
