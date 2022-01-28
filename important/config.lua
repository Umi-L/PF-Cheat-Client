getgenv().config = {
    aimbot = {
        silent_aim = false,
        hit_chance = 100,
        field_of_view = false,
        field_of_view_range = 180,
        target_part = "torso"
    },
    character = {
        walkspeed = false,
        jumppower = false,
        fake_lag = false,
        fake_lag_limit = 15,
        auto_deploy = false,
        antiaim = true,
        -- antiaim_look = "down",
        antiaim_stance = "stand"
    },
    gunmod = {
        fast_equip = false,
        fast_reload = false,
        no_recoil = false
    },
    visuals = {
        esp_enabled = true,
        esp_not_visible_shown = true,
        esp_visible_shown = true,
        esp_colour = Color3.fromRGB(255, 0, 0),
        esp_visible_colour = Color3.fromRGB(0, 255, 0)
    }
}