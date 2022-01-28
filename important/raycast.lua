getgenv().cast_ray = function (body_part)
    local rp = RaycastParams.new()
    rp.FilterDescendantsInstances = localplayer:GetDescendants()
    rp.FilterType = Enum.RaycastFilterType.Blacklist

    local rcr = workspace:Raycast(camera.CFrame.Position, (body_part.Position - camera.CFrame.Position).Unit * 15000,rp)
    if rcr and rcr.Instance:IsDescendantOf(body_part.Parent) then
        return true
    else
        return false
    end
end