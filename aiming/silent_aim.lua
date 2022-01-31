-- local l__CFrame__1003 = (u215 and u211.sightpart or v909).CFrame;
-- (is_aiming and SIGHT or Barrel).cframe

local Players = game:GetService("Players")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local GameLogic, CharTable, Trajectory

math.randomseed(os.time())


for I,V in pairs(getgc(true)) do
    if type(V) == "table" then
        if rawget(V, "gammo") then
            GameLogic = V
        end
    elseif type(V) == "function" then
        if debug.getinfo(V).name == "getbodyparts" then
            CharTable = debug.getupvalue(V, 1)
        elseif debug.getinfo(V).name == "trajectory" then
            Trajectory = V
        end
    end
    if GameLogic and CharTable and Trajectory then break end
end

local function Closest()
    local Max, Close = math.huge
    for I,V in pairs(Players:GetPlayers()) do
        if V ~= LocalPlayer and V.Team ~= LocalPlayer.Team and CharTable[V] then
            local Pos, OnScreen = Camera:WorldToScreenPoint(CharTable[V].torso.Position)

            if OnScreen then
                local Dist = (Vector2.new(Pos.X, Pos.Y) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
                if Dist < Max then
                    if config.aimbot.field_of_view ~= true or Dist <= config.aimbot.field_of_view_range then
                        if config.aimbot.only_shoot_visible ~= true or cast_ray(CharTable[V].torso) or cast_ray(CharTable[V].head) then
                            Max = Dist
                            Close = V
                        end
                    end
                end
            end
        end
    end
    return Close
end

local MT = getrawmetatable(game)
local __index = MT.__index

setreadonly(MT, false)
MT.__index = newcclosure(function(self, K)
    if config.aimbot.silent_aim == true then
        if not checkcaller() and GameLogic.currentgun and GameLogic.currentgun.data and (self == GameLogic.currentgun.barrel or tostring(self) == "SightMark") and K == "CFrame" then

            local rand = math.random(100)
            local CharChosen

            if rand < config.aimbot.headshot_percentage then
                CharChosen = (CharTable[Closest()] and CharTable[Closest()].head)
            else
                CharChosen = (CharTable[Closest()] and CharTable[Closest()].torso)
            end

            if CharChosen then
                local _, Time = Trajectory(self.Position, Vector3.new(0, -workspace.Gravity, 0), CharChosen.Position, GameLogic.currentgun.data.bulletspeed)
                return CFrame.new(self.Position, CharChosen.Position + (Vector3.new(0, -workspace.Gravity / 2, 0)) * (Time ^ 2) + (CharChosen.Velocity * Time))
            end
        end
    end
    return __index(self, K)
end)
setreadonly(MT, true)


















--[[
local function is_gunsight(t)
    local sightparts = gun_system.currentgun and gun_system.currentgun.aimsightdata
    for _, sightdata in next, sightparts do
        if sightdata.sightpart == t then
            return true
        end
    end
    return false
end

local old_index old_index = hookmetamethod(game, "__index", function(t, k)
    if k == "CFrame" and config.aimbot.silent_aim and gun_system.currentgun and (is_gunsight(t) or t == gun_system.currentgun.barrel) then
        local r = weighted_random({hit = config.aimbot.hit_chance,miss = 100 - config.aimbot.hit_chance})

        local cf = old_index(t, k)
        local c_player, c_bodyparts = get_closest()
        if c_player and c_bodyparts and c_player.Team ~= player.Team and r == "hit" then
            return CFrame.new(
                cf.Position,
                c_bodyparts[config.aimbot.target_part].Position
            )
        end
    end
    return old_index(t, k)
end)
]]