SettingsMenu = {}

function SettingsMenu.SetupMenu(mod)  -- mod = DWN_ToggleNeonRims
    local languageContent = mod.utilities.GetLanguageData(mod)
    local nativeSettings = GetMod("nativeSettings")
    if not nativeSettings then
        print("[Improved Neon Rims Control] Error: NativeSettings UI not installed.")
        return
    end

    nativeSettings.addTab("/neon_rims_improvements", languageContent.SettingsTabTitle)
    nativeSettings.addSubcategory("/neon_rims_improvements/cat1", languageContent.MainCategoryTitle)
    nativeSettings.addSubcategory("/neon_rims_improvements/cat2", languageContent.BikesCategoryTitle)
    nativeSettings.addSubcategory("/neon_rims_improvements/cat3", languageContent.HeadlightsCategoryTitle)

    -- Settings cat1
    nativeSettings.addSwitch("/neon_rims_improvements/cat1", languageContent.SwitchOnBikeTitle, languageContent.SwitchOnBikeDesc, mod.settings.turnOnWhenEnter, true, function(state)
        mod.settings.turnOnWhenEnter = state
        SettingsMenu.SaveUserSettings(mod)
    end)

    nativeSettings.addSwitch("/neon_rims_improvements/cat1", languageContent.SwitchOffBikeTitle, languageContent.SwitchOffBikeDesc, mod.settings.turnOnWhenExit, true, function(state)
        mod.settings.turnOnWhenExit = state
        SettingsMenu.SaveUserSettings(mod)
    end)

    -- Settings cat2
    nativeSettings.addSwitch("/neon_rims_improvements/cat2", languageContent.ApplyOnlyOnBikesTitle, languageContent.ApplyOnlyOnBikesDesc, mod.settings.applyOnlyOnBikes, false, function(state)
        mod.settings.applyOnlyOnBikes = state
        SettingsMenu.SaveUserSettings(mod)
    end)

    nativeSettings.addSwitch("/neon_rims_improvements/cat2", languageContent.ApplyToggleOnlyOnBikesTitle, languageContent.ApplyToggleOnlyOnBikesDesc, mod.settings.applyToggleOnlyOnBikes, false, function(state)
        mod.settings.applyToggleOnlyOnBikes = state
        SettingsMenu.SaveUserSettings(mod)
    end)

    -- Settings cat3
    nativeSettings.addSwitch("/neon_rims_improvements/cat3", languageContent.TurnHeadlightsOnTitle, languageContent.TurnHeadlightsOnDesc, mod.settings.turnHeadlightsOn, false, function(state)
        mod.settings.turnHeadlightsOn = state
        SettingsMenu.SaveUserSettings(mod)
    end)

    nativeSettings.addSwitch("/neon_rims_improvements/cat3", languageContent.ToggleHeadlightsTitle, languageContent.ToggleHeadlightsDesc, mod.settings.toggleHeadlights, false, function(state)
        mod.settings.toggleHeadlights = state
        SettingsMenu.SaveUserSettings(mod)
    end)

    nativeSettings.refresh()
end

function SettingsMenu.LoadUserSettings(mod)
    local file = io.open('settings.json', 'r')
    if file ~= nil then
        local contents = file:read("*a")
        local validJson, savedSettings = pcall(function() return json.decode(contents) end)
        file:close()

        if validJson then
            for key, _ in pairs(mod.settings) do
                if savedSettings[key] ~= nil then
                    mod.settings[key] = savedSettings[key]
                end
            end
        end
    end
end

function SettingsMenu.SaveUserSettings(mod)
    local validJson, contents = pcall(function() return json.encode(mod.settings) end)

    if validJson and contents ~= nil then
        local file = io.open("settings.json", "w+")
        file:write(contents)
        file:close()
    end
end

return SettingsMenu