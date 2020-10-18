$(document).ready(function () {
  // create new object
  $("#create_object").click(function (e) {
    CallEvent("opus:CreateObject", $("#create_modelid").val());
  });
  // create new object
  $("#destroy_object").click(function (e) {
    CallEvent("opus:DestroyObject");
  });

  // attach object to player
  $("#attach_object").click(function (e) {
    CallEvent(
      "opus:AttachObject",
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
  $("#detach_object").click(function (e) {
    CallEvent("opus:DetachObject");
  });

  // add component to attach object
  $("#add_component").click(function (e) {
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
  // detach object from player
  $("#destroy_component").click(function (e) {
    CallEvent("opus:DestroyComponent");
  });
});
