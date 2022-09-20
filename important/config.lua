getgenv().config = {
    aimbot = {
        silent_aim = true,
        hit_chance = 100,
        field_of_view = true,
        field_of_view_range = 20,
        headshot_percentage = 20,
        only_shoot_visible = true
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
        fast_reload_speed = 0.1,
        no_recoil = false,
    },
    visuals = {
        esp_enabled = true,
        esp_not_visible_shown = false,
        esp_visible_shown = true,
        esp_colour = Color3.fromRGB(255, 0, 0),
        esp_visible_colour = Color3.fromRGB(0, 255, 0),
        balistics_tracker_enabled = true,
        balistics_tracker_visible_thru_walls = false,
    }
}