local AttachedData = {}

AddEvent("OnPackageStop", function()
  for player,data in pairs(AttachedData) do
    DestroyObject(data.object)
  end
  AttachedData = {}
end)

-- Attach object
AddRemoteEvent("AdjustAttachmentPosition", function(player, modelid, bone, x, y, z, rx, ry, rz)
  if AttachedData[player] ~= nil then
      DestroyObject(AttachedData[player].object)
      AttachedData[player] = nil
  end

  x = x or 0
  y = y or 0
  z = z or 0
  rx = rx or 0
  ry = ry or 0
  rz = rz or 0

  local _x, _y, _z = GetPlayerLocation(player)
  AttachedData[player] = {
      modelid = modelid,
      bone = bone,
      object = CreateObject(modelid, _x, _y, _z)
  }

  SetObjectAttached(AttachedData[player].object, ATTACH_PLAYER, player, x, y, z, rx, ry, rz, bone)

  info = string.format("SetObjectAttached([...], %d, %d, %d, %d, %d, %d, %s)", x, y, z, rx, ry, rz, bone)
  CallRemoteEvent(player, "UpdateCodeBox", info)
  AddPlayerChat(player, "OPUS: Object attached.  Use detach to remove.")
end)

-- Set attached object property value to given location and rotation vectors
AddRemoteEvent("AdjustComponentPosition", function(player, x, y, z, rx, ry, rz)
    if AttachedData[player] == nil then
        AddPlayerChat(player, "OPUS: Must first attach an object to add a light component to!")
        return
    end

    local pos = { x = x, y = y, z = z, rx = rx, ry = ry, rz = rz }
    SetObjectPropertyValue(AttachedData[player].object, "component_position", pos)
    AddPlayerChat(player, "OPUS: Attached light component to attached object!")
end)

AddCommand("dddddetach", function(player)
    DetachObjects(player)
    AddPlayerChat(player, "Object has been detached")
end)

function dump(o)
    if type(o) == 'table' then
        local s = '{ '
        for k, v in pairs(o) do
            if type(k) ~= 'number' then
                k = '"' .. k .. '"'
            end
            s = s .. '[' .. k .. '] = ' .. dump(v) .. ','
        end
        return s .. '} '
    else
        return tostring(o)
    end
end
