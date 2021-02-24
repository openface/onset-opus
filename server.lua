local AttachedData = {}

local Objects = {}

AddEvent("OnPackageStop", function()
  for player,object in pairs(Objects) do
    DestroyObject(object)
  end
  Objects = {}
end)

--
-- Objects
--

-- Create object near player
AddRemoteEvent("opus:CreateObject", function(player, modelid)
  if Objects[player] ~= nil then
    DestroyObject(Objects[player])
  end

  local _x, _y, _z = GetPlayerLocation(player)
  Objects[player] = CreateObject(modelid, _x, _y+100, _z-75)
  AddPlayerChat(player, "OPUS: Object created near player")
end)

-- Destroy object
AddRemoteEvent("opus:DestroyObject", function(player)
    if Objects[player] ~= nil then
        DestroyObject(Objects[player])
        Objects[player] = nil
        AddPlayerChat(player, "OPUS: Object destroyed")
    end
end)

--
-- Attachments
--

-- Attach object to player
AddRemoteEvent("opus:AttachObject", function(player, bone, x, y, z, rx, ry, rz, scale)
  if Objects[player] == nil then
    AddPlayerChat(player, "OPUS: Must first create object to attach to player")
    return
  end

  if IsObjectAttached(Objects[player]) then
    SetObjectDetached(Objects[player])
  end

  x = x or 0
  y = y or 0
  z = z or 0
  rx = rx or 0
  ry = ry or 0
  rz = rz or 0
  scale = scale or 0.5

  SetObjectScale(Objects[player], scale, scale, scale)

  SetObjectAttached(Objects[player], ATTACH_PLAYER, player, x, y, z, rx, ry, rz, bone)
  AddPlayerChat(player, "OPUS: Object attached to player")
end)

-- Detach object from player
AddRemoteEvent("opus:DetachObject", function(player)
    if Objects[player] == nil then
      AddPlayerChat(player, "OPUS: Must first create object to attach to player")
      return
    end

    if IsObjectAttached(Objects[player]) then
      SetObjectDetached(Objects[player])
      AddPlayerChat(player, "OPUS: Object detached from player")
    end
end)

--
-- Components
--

-- Set attached object property value to given location and rotation vectors
AddRemoteEvent("opus:AddComponent", function(player, type, x, y, z, rx, ry, rz)
    if Objects[player] == nil then
      AddPlayerChat(player, "OPUS: Must first create object to add a component to!")
      return
    end

    local comp = {
      type = type,
      position = { x = x, y = y, z = z, rx = rx, ry = ry, rz = rz }
    }
    CallRemoteEvent(player, "SetComponent", Objects[player], comp)
    AddPlayerChat(player, "OPUS: Added light component to object!")
end)

-- Remove component from object
AddRemoteEvent("opus:DestroyComponent", function(player)
  if Objects[player] == nil then
    AddPlayerChat(player, "OPUS: There is no object")
    return
  end
  CallRemoteEvent(player, "RemoveComponent", Objects[player])
  AddPlayerChat(player, "OPUS: Removed light component from object!")
end)

