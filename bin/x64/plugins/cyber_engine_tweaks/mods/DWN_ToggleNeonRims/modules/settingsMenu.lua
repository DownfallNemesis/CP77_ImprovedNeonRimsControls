SettingsMenu = {}

function SettingsMenu.SetupMenu()
    local languageContent = DWN_ToggleNeonRims.Utilities.GetLanguageData()
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
    nativeSettings.addKeyBinding("/neon_rims_improvements/cat1", languageContent.HotkeyTitle, languageContent.HotkeyDescription, DWN_ToggleNeonRims.settings.toggleKey, "IK_5", false, function(key)
        DWN_ToggleNeonRims.settings.toggleKey = key
        SettingsMenu.SaveUserSettings()
    end)

    nativeSettings.addSwitch("/neon_rims_improvements/cat1", languageContent.SwitchOnBikeTitle, languageContent.SwitchOnBikeDesc, DWN_ToggleNeonRims.settings.turnOnWhenEnter, true, function(state)
        DWN_ToggleNeonRims.settings.turnOnWhenEnter = state
        SettingsMenu.SaveUserSettings()
    end)

    nativeSettings.addSwitch("/neon_rims_improvements/cat1", languageContent.SwitchOffBikeTitle, languageContent.SwitchOffBikeDesc, DWN_ToggleNeonRims.settings.turnOnWhenExit, true, function(state)
        DWN_ToggleNeonRims.settings.turnOnWhenExit = state
        SettingsMenu.SaveUserSettings()
    end)

    -- Settings cat2
    nativeSettings.addSwitch("/neon_rims_improvements/cat2", languageContent.ApplyOnlyOnBikesTitle, languageContent.ApplyOnlyOnBikesDesc, DWN_ToggleNeonRims.settings.applyOnlyOnBikes, false, function(state)
        DWN_ToggleNeonRims.settings.applyOnlyOnBikes = state
        SettingsMenu.SaveUserSettings()
    end)

    nativeSettings.addSwitch("/neon_rims_improvements/cat2", languageContent.ApplyToggleOnlyOnBikesTitle, languageContent.ApplyToggleOnlyOnBikesDesc, DWN_ToggleNeonRims.settings.applyToggleOnlyOnBikes, false, function(state)
        DWN_ToggleNeonRims.settings.applyToggleOnlyOnBikes = state
        SettingsMenu.SaveUserSettings()
    end)

    -- Settings cat3
    nativeSettings.addSwitch("/neon_rims_improvements/cat3", languageContent.TurnHeadlightsOnTitle, languageContent.TurnHeadlightsOnDesc, DWN_ToggleNeonRims.settings.turnHeadlightsOn, false, function(state)
        DWN_ToggleNeonRims.settings.turnHeadlightsOn = state
        SettingsMenu.SaveUserSettings()
    end)

    nativeSettings.addSwitch("/neon_rims_improvements/cat3", languageContent.ToggleHeadlightsTitle, languageContent.ToggleHeadlightsDesc, DWN_ToggleNeonRims.settings.toggleHeadlights, false, function(state)
        DWN_ToggleNeonRims.settings.toggleHeadlights = state
        SettingsMenu.SaveUserSettings()
    end)

    nativeSettings.refresh()
end

function SettingsMenu.LoadUserSettings()
    local file = io.open('settings.json', 'r')
    if file ~= nil then
        local contents = file:read("*a")
        local validJson, savedSettings = pcall(function() return json.decode(contents) end)
        file:close()

        if validJson then
            for key, _ in pairs(DWN_ToggleNeonRims.settings) do
                if savedSettings[key] ~= nil then
                    DWN_ToggleNeonRims.settings[key] = savedSettings[key]
                end
            end
        end
    end
end

function SettingsMenu.SaveUserSettings()
    local validJson, contents = pcall(function() return json.encode(DWN_ToggleNeonRims.settings) end)

    if validJson and contents ~= nil then
        local file = io.open("settings.json", "w+")
        file:write(contents)
        file:close()
    end
end

return SettingsMenu