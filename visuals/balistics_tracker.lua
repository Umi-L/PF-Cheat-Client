local e_plrlist
local rs = game:GetService("RunService")

local GameLogic
local Trajectory
local CharTable

local camera = workspace.CurrentCamera

for I, V in pairs(getgc(true)) do
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
	if GameLogic and CharTable and Trajectory then
		break
	end
end

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

local function getBulletDropPos(CharChosen)
	local self = camera.CFrame

	local _, Time = Trajectory(
		self.Position,
		Vector3.new(0, -workspace.Gravity, 0),
		CharChosen.Position,
		GameLogic.currentgun.data.bulletspeed
	)
	return CharChosen.Position + (Vector3.new(0, workspace.Gravity / 2, 0)) * (Time ^ 2) + (CharChosen.Velocity * Time)
end

rs.Stepped:Connect(function()
	e_plrlist = geteplrlist()
end)

local drawn = {}

rs.RenderStepped:Connect(function()

    if (not config.visuals.balistics_tracker_enabled) then
        for i, v in pairs(drawn) do
            v:Remove()
            drawn[i] = nil
        end

        return
    end

	for i, v in pairs(drawn) do
		drawn[i]:Remove()
		drawn[i] = nil
	end

	for i, v in next, e_plrlist do
		if GameLogic.currentgun and GameLogic.currentgun.data then

            local bulletDropPos = getBulletDropPos(v:FindFirstChild("Head"))
			local vector, inViewport = camera:WorldToViewportPoint(bulletDropPos)

            local checkPart = Instance.new("Part")
            checkPart.Parent = v:FindFirstChild("Head")
            checkPart.Anchored = true
            checkPart.Position = bulletDropPos


			if inViewport then

                if cast_ray(checkPart) or config.visuals.balistics_tracker_visible_thru_walls then

                    print("Drawing visible thru = ", config.visuals.balistics_tracker_visible_thru_walls)

                    local drawing = Drawing.new("Quad")
                    local drawingPos = Vector2.new(vector.X, vector.Y)

                    local distanceFromCenter = 2;

                    drawing.PointA = drawingPos + Vector2.new(0, distanceFromCenter)
                    drawing.PointB = drawingPos + Vector2.new(distanceFromCenter, 0)
                    drawing.PointC = drawingPos + Vector2.new(0, -distanceFromCenter)
                    drawing.PointD = drawingPos + Vector2.new(-distanceFromCenter, 0)

                    drawing.Visible = true
                    drawing.Filled = true
                    drawing.Color = Color3.fromRGB(255, 255, 255)

                    drawn[i] = drawing

                end
			end

            checkPart:Remove()
		end
	end
end)
