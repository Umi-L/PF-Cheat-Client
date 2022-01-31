--[[
    credits: B1luee22
]]

local plr = game.Players.LocalPlayer
local cam = workspace.CurrentCamera

getgenv().cast_ray = function(body_part)
    local l_character = plr.Character or plr.CharacterAdded:wait()

    local rp = RaycastParams.new()
    rp.FilterDescendantsInstances = l_character:GetDescendants()
    rp.FilterType = Enum.RaycastFilterType.Blacklist

    if cam ~= nil or body_part ~= nil or rp ~= nil then

        local rcr = workspace:Raycast(cam.CFrame.Position, (body_part.Position - cam.CFrame.Position).Unit * 15000,rp)
        if rcr and rcr.Instance:IsDescendantOf(body_part.Parent) then
            return true
        else
            return false
        end
    else
        return false
    end
end

print("debug")