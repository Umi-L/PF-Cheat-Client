local e_plrlist
local rs = game:GetService("RunService")

local function geteplrlist()
    local t = {}
    local team_color_to_string = tostring(game.Players.LocalPlayer.TeamColor)

    if team_color_to_string == "Bright orange" then
        t = workspace.Players["Bright blue"]:GetChildren()
    else
        t = workspace.Players["Bright orange"]:GetChildren()
    end

    return t
end

rs.Stepped:Connect(function()
e_plrlist = geteplrlist()
end)

local function check_for_esp(c_model)
    if not c_model then
        return
    else
        returnv = false
        for i,v in next, c_model:GetDescendants() do
            if v:IsA("BoxHandleAdornment") then
                returnv = true
                break
                end
            end
        return returnv
    end
end

local function remove_esp(c_model)
    for i,v in next, c_model:GetDescendants() do
        if v:IsA("BoxHandleAdornment") then
            v:Destroy()
        end
    end
end

local function create_esp(c_model)
    if not c_model then
        return
    else
        if check_for_esp(c_model) then
            for i,v in next, c_model:GetChildren() do
                if v:IsA("BasePart") and v:FindFirstChild("BoxHandleAdornment") then
                    local walt = v:FindFirstChild("BoxHandleAdornment")
                    if cast_ray(v) then
                        walt.Visible = config.visuals.esp_visible_shown
                        walt.Color3 = config.visuals.esp_visible_colour
                    else
                        walt.Visible = config.visuals.esp_not_visible_shown
                        walt.Color3 = config.visuals.esp_colour
                    end
                end
            end
        else
            for i,v in next, c_model:GetChildren() do
                if v:IsA("BasePart") then
                    local b = Instance.new("BoxHandleAdornment")
                    b.Parent = v
                    b.Adornee = v
                    b.AlwaysOnTop = true
                    b.Size = v.Size
                    b.ZIndex = 2
                    b.Transparency = 0.5
                end
            end
        end
    end
end

rs.RenderStepped:Connect(function()
    for i,v in next, e_plrlist do
        if config.visuals.esp_enabled then
            create_esp(v)
        else
            remove_esp(v)
        end
    end
end)