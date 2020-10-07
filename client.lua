local i = 10
local x = 0
local y = 0
local z = 0
local rx = 0
local ry = 0
local rz = 0

AddEvent("OnPackageStart", function()
  INFO = CreateWebUI(0.0, 0.0, 0.0, 0.0, 1, 1)
  SetWebAnchors(INFO, 0.0, 0.6, 0.4, 1.0)
  LoadWebFile(INFO, 'http://asset/' .. GetPackageName() .. '/ui/info.html')
  SetWebVisibility(INFO, WEB_HITINVISIBLE)
end)


function OnKeyPress(key)
    if key == "N" then
        if IsShiftPressed() then
            i = i - 1
            AddPlayerChat("Incrementation decreased to: "..i)  
        else
            i = i + 1
            AddPlayerChat("Incrementation increased to: "..i)
        end
    elseif key == "X" then
        if IsShiftPressed() then
            x = x - i
        else
            x = x + i
        end
        CallRemoteEvent("ReAttachObject", x, y, z, rx, ry, rz)
    elseif key == "Y" then
        -- Y
        if IsShiftPressed() then
            y = y - i
        else
            y = y + i
        end 
        CallRemoteEvent("ReAttachObject", x, y, z, rx, ry, rz)
    elseif key == "Z" then
        -- Z
        if IsShiftPressed() then
            z = z - i
        else
            z = z + i
        end 
        CallRemoteEvent("ReAttachObject", x, y, z, rx, ry, rz)
    elseif key == "J" then
        -- RX
        if IsShiftPressed() then
            rx = rx - i
        else
            rx = rx + i
        end 
        CallRemoteEvent("ReAttachObject", x, y, z, rx, ry, rz)
    elseif key == "K" then
        -- RY
        if IsShiftPressed() then
            ry = ry - i
        else
            ry = ry + i
        end 
        CallRemoteEvent("ReAttachObject", x, y, z, rx, ry, rz)
    elseif key == "L" then
        -- RZ
        if IsShiftPressed() then
            rz = rz - i
        else
            rz = rz + i
        end 
        CallRemoteEvent("ReAttachObject", x, y, z, rx, ry, rz)
    end
end
AddEvent("OnKeyPress", OnKeyPress)