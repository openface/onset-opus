local OpusUI

AddEvent("OnPackageStart", function()
  OpusUI = CreateWebUI(0.0, 0.0, 0.0, 0.0)
  SetWebAnchors(OpusUI, 0.0, 0.0, 1.0, 1.0)
  LoadWebFile(OpusUI, 'http://asset/' .. GetPackageName() .. '/ui/info.html')
  SetWebVisibility(OpusUI, WEB_HIDDEN)
end)

AddEvent("OnPackageStop", function()
  DestroyWebUI(OpusUI)
end)

AddEvent("OnKeyPress", function(key)
    if key == "F5" then
        if GetWebVisibility(OpusUI) == WEB_HIDDEN then
            SetWebVisibility(OpusUI, WEB_VISIBLE)
            SetInputMode(INPUT_GAMEANDUI)
            ShowMouseCursor(true)
            SetIgnoreMoveInput(true)
        else
            SetWebVisibility(OpusUI, WEB_HIDDEN)
            SetInputMode(INPUT_GAME)
            ShowMouseCursor(false)
            SetIgnoreMoveInput(false)
        end
    end
end)



AddEvent("OnConsoleInput", function(input)
  args = split_string(input)
  local cmd = args[1]
  
  if cmd ~= "attach" and cmd ~= "light" then
      return
  end

  if cmd == "attach" then
    local modelid = args[2]
    local x = args[3]
    local y = args[4]
    local z = args[5]
    local rx = args[6]
    local ry = args[7]
    local rz = args[8]
    local bone = args[9]

    if bone == nil then
      AddPlayerChat("Usage: attach <modelid> <x> <y> <z> <rx> <ry> <rz> <bone>")
      return
    end
    CallRemoteEvent("AdjustAttachmentPosition", modelid, bone, x, y, z, rx, ry, rz)
  elseif cmd == "light" then
    local x = args[2]
    local y = args[3]
    local z = args[4]
    local rx = args[5]
    local ry = args[6]
    local rz = args[7]

    if rz == nil then
        AddPlayerChat("Usage: light <x> <y> <z> <rx> <ry> <rz>")
        return
    end
    CallRemoteEvent("AdjustComponentPosition", x, y, z, rx, ry, rz)
  end
end)

function split_string(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t = {}
    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
        table.insert(t, str)
    end
    return t
end

AddRemoteEvent("UpdateCodeBox", function(info)
  ExecuteWebJS(OpusUI, "UpdateCodeBox('"..info.."')")
end)


--
-- Pointlight
--
local Component

function AdjustComponentPosition(object, x, y, z, rx, ry, rz)
    if object == nil then
      return
    end
    if Component ~= nil then
      Component:Destroy()
    end

    local Actor = GetObjectActor(object)
    Actor:SetActorEnableCollision(false)

    Component = Actor:AddComponent(USpotLightComponent.Class())
    Component:SetIntensity(10000 * 30)
    Component:SetLightColor(FLinearColor(255, 255, 255, 0), true)
    Component:SetRelativeLocation(FVector(x, y, z))
    Component:SetRelativeRotation(FRotator(rx, ry, rz))

    local info = string.format('SetRelativeRotation(FRotator(%d, %d, %d))', rx, ry, rz)
    print(info)
    AddPlayerChat(info)
end

AddEvent("OnObjectStreamIn", function(object)
    local pos = GetObjectPropertyValue(object, "component_position")
    if pos ~= nil then
      AdjustComponentPosition(object, pos.x, pos.y, pos.z, pos.rx, pos.ry, pos.rz)
    end
end)

AddEvent("OnObjectStreamOut", function(object)
    local pos = GetObjectPropertyValue(object, "component_position")
    if pos ~= nil and Component ~= nil then
      Component:Destroy()
    end
end)

AddEvent("OnObjectNetworkUpdatePropertyValue", function(object, name, value)
    if name == "component_position" then
      AdjustComponentPosition(object, value.x, value.y, value.z, value.rx, value.ry, value.rz)
    end
end)

