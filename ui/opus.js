$(document).ready(function () {
  /* Object Spawning */

  // create new object
  $("#create_object").click(function (e) {
    CallEvent("opus:CreateObject", $("#create_modelid").val());
  });
  // destroy object
  $("#destroy_object").click(function (e) {
    CallEvent("opus:DestroyObject");
  });

  /* Coordinate controls */

  // cooldown so we don't flood the game when slider values change
  var lastUpdate = Date.now();

  // mapping of element id of coordinate and the set element id
  const coordsMap = [
    { coord_el: "light_x", set_el: "set_component" },
    { coord_el: "light_y", set_el: "set_component" },
    { coord_el: "light_z", set_el: "set_component" },
    { coord_el: "light_rx", set_el: "set_component" },
    { coord_el: "light_ry", set_el: "set_component" },
    { coord_el: "light_rz", set_el: "set_component" },
    { coord_el: "attach_x", set_el: "attach_object" },
    { coord_el: "attach_y", set_el: "attach_object" },
    { coord_el: "attach_z", set_el: "attach_object" },
    { coord_el: "attach_rx", set_el: "attach_object" },
    { coord_el: "attach_ry", set_el: "attach_object" },
    { coord_el: "attach_rz", set_el: "attach_object" }
  ];
  $.each(coordsMap, function (_,map) {

    // listen to slider; update textbox value and trigger SET event
    $("#" + map.coord_el + "_slider").on("input change", (e) => {
      $("#" + map.coord_el).val(e.target.value);
      if (Date.now() > lastUpdate + 50) {
        lastUpdate = Date.now();
        $("#" + map.set_el).trigger("click");
      }
    });

    // listen to textbox; update slider value
    $("#" + map.coord_el).on("change", (e) => {
      $("#" + map.coord_el + "_slider").val(e.target.value);
      $("#" + map.set_el).trigger("click");
    });
  });

  /* Light Component */

  // add component to object
  $("#set_component").click(function (e) {
    CallEvent(
      "opus:SetComponent",
      $("#light_type option:selected").val(),
      $("#light_x").val(),
      $("#light_y").val(),
      $("#light_z").val(),
      $("#light_rx").val(),
      $("#light_ry").val(),
      $("#light_rz").val()
    );
  });
  // destroy component
  $("#destroy_component").click(function (e) {
    CallEvent("opus:DestroyComponent");
  });

  /** Player Attachment */

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
});
