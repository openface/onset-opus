local AttachedData = {}
local object
local bone
local modelid

--local bone = "hand_r"
--local modelid = 1673

function AdjustAttachmentPosition(player, x, y, z, rx, ry, rz)
	if AttachedData[player] == nil then
		print "Nothing attached!"
		return
	end

	AttachObjectToPlayer(player, AttachedData[player].modelid, AttachedData[player].bone, x, y, z, rx, ry, rz)
end
AddRemoteEvent("ReAttachObject", AdjustAttachmentPosition)

function AttachObjectToPlayer(player, modelid, bone, x, y, z, rx, ry, rz)
	DetachObjects(player)

	AttachedData[player] = { modelid = modelid, bone = bone }

	x = x or 0
	y = y or 0
	z = z or 0
	rx = rx or 0
	ry = ry or 0
	rz = rz or 0

	local _x,_y,_z = GetPlayerLocation(player)
	AttachedData[player].object = CreateObject(modelid, _x, _y, _z)
	SetObjectAttached(AttachedData[player].object, ATTACH_PLAYER, player, x, y, z, rx, ry, rz, bone)

	local info = string.format('{ x = %q, y = %q, z = %q, rx = %q, ry = %q, rz = %q, bone = "%q" }', x, y, z, rx, ry, rz, bone)
	AddPlayerChat(player, info)
	print(info)
end

function DetachObjects(player)
	if AttachedData[player] ~= nil then
		DestroyObject(AttachedData[player].object)
		AttachedData[player] = nil
	end
end

AddCommand("attach", function(player, modelid, bone)
	AddPlayerChat(player, "Attached object "..modelid.." to bone "..bone)
	AttachObjectToPlayer(player, modelid, bone)
end)

AddCommand("detach", function(player)
	DetachObjects(player)
	AddPlayerChat(player, "Object has been detached")
end)

function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end