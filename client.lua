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
AddEvent("opus:SetComponent", function(type, x, y, z, rx, ry, rz)
    CallRemoteEvent("opus:AddComponent", type, x, y, z, rx, ry, rz)
end)

AddEvent("opus:DestroyComponent", function()
    CallRemoteEvent("opus:DestroyComponent")
end)

--
-- Light Component
--
local Component

function AdjustComponentPosition(object, type, x, y, z, rx, ry, rz)
    if Component ~= nil then
      Component:Destroy()
      Component = nil
    end

    local Actor = GetObjectActor(object)
    Actor:SetActorEnableCollision(false)

    if type == "spotlight" then
      Component = Actor:AddComponent(USpotLightComponent.Class())
    elseif type == "pointlight" then
      Component = Actor:AddComponent(UPointLightComponent.Class())
    elseif type == "rectlight" then
      Component = Actor:AddComponent(URectLightComponent.Class())
    end
    Component:SetIntensity(30000)
    Component:SetLightColor(FLinearColor(255, 255, 255, 0), true)
    Component:SetRelativeLocation(FVector(x, y, z))
    Component:SetRelativeRotation(FRotator(rx, ry, rz))
    AddPlayerChat("OPUS: Component location and rotation set")
end


AddRemoteEvent("SetComponent", function(object, comp)
    AdjustComponentPosition(object, comp.type, comp.position.x, comp.position.y, comp.position.z, comp.position.rx, comp.position.ry, comp.position.rz)
end)

AddRemoteEvent("RemoveComponent", function(object)
    if Component ~= nil then
      Component:Destroy()
    end
end)


