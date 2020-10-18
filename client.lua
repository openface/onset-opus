local OpusUI

AddEvent("OnPackageStart", function()
  OpusUI = CreateWebUI(0.0, 0.0, 0.0, 0.0)
  SetWebAnchors(OpusUI, 0.0, 0.0, 1.0, 1.0)
  LoadWebFile(OpusUI, 'http://asset/' .. GetPackageName() .. '/ui/opus.html')
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

-- object
AddEvent("opus:CreateObject", function(modelid)
    CallRemoteEvent("opus:CreateObject", modelid)
end)

AddEvent("opus:DestroyObject", function()
    CallRemoteEvent("opus:DestroyObject")
end)


-- attachment
AddEvent("opus:AttachObject", function(modelid, bone, x, y, z, rx, ry, rz)
  CallRemoteEvent("opus:AttachObject", modelid, bone, x, y, z, rx, ry, rz)
end)

AddEvent("opus:DetachObject", function()
    CallRemoteEvent("opus:DetachObject")
end)

-- component
AddEvent("opus:AddComponent", function(x, y, z, rx, ry, rz)
    CallRemoteEvent("opus:AddComponent", x, y, z, rx, ry, rz)
end)

AddEvent("opus:DestroyComponent", function()
    CallRemoteEvent("opus:DestroyComponent")
end)

--
-- Pointlight
--
local Component

function AdjustComponentPosition(object, x, y, z, rx, ry, rz)
    if Component ~= nil then
      Component:Destroy()
    end

    local Actor = GetObjectActor(object)
    Actor:SetActorEnableCollision(false)

    Component = Actor:AddComponent(USpotLightComponent.Class())
    Component:SetIntensity(30000)
    Component:SetLightColor(FLinearColor(255, 255, 255, 0), true)
    Component:SetRelativeLocation(FVector(x, y, z))
    Component:SetRelativeRotation(FRotator(rx, ry, rz))
    AddPlayerChat("OPUS: Component location and rotation set")
end

AddEvent("OnObjectStreamIn", function(object)
    local pos = GetObjectPropertyValue(object, "component_position")
    if pos == nil then
      return
    end

    if pos ~= false then
      AdjustComponentPosition(object, pos.x, pos.y, pos.z, pos.rx, pos.ry, pos.rz)
    end
end)

AddEvent("OnObjectStreamOut", function(object)
    local pos = GetObjectPropertyValue(object, "component_position")
    if pos == nil then
      return false
    end
    
    if pos == false and Component ~= nil then
      Component:Destroy()
    end
end)

AddEvent("OnObjectNetworkUpdatePropertyValue", function(object, name, value)
    if name == "component_position" then
      if value == false then
        Component:Destroy()
      else
        AdjustComponentPosition(object, value.x, value.y, value.z, value.rx, value.ry, value.rz)
      end
    end
end)

