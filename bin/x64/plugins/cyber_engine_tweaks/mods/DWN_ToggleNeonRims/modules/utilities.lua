Utilities = {}

function Utilities.GetVehicleName()
    local vehicleName = Game.GetMountedVehicle(Game.GetPlayer()):GetDisplayName()
    vehicleName = vehicleName:gsub(" ", "_")
    vehicleName = vehicleName:gsub("\"", "")
    vehicleName = vehicleName:gsub("'", "")

    return vehicleName
end

function Utilities.LoadJsonFile(filePath)
    local jsonFile = io.open(filePath..".json", "r")
    if not jsonFile then return nil end

    local jsonContent = json.decode(jsonFile:read("*a"))
    jsonFile:close()

    return jsonContent
end

function Utilities.ReadBikeNames()
    local bikeNameArray = {}
    local bikeListFile = io.open("files/bikeNames.txt", "r")
    for line in bikeListFile:lines() do
        table.insert(bikeNameArray, line)
    end

    return bikeNameArray
end

function Utilities.IsValueInArray(array, val)
    for index, value in ipairs(array) do
        if value == val then
            return true
        end
    end
end

function Utilities.GetLanguageData()
    local gameLang = Game.NameToString(Game.GetSettingsSystem():GetVar("/language", "OnScreen"):GetValue())
    local filePath = DWN_ToggleNeonRims.folderPaths.languageFolder..gameLang
    local languageContent = Utilities.LoadJsonFile(filePath)

    --Fallback if language file is missing
    if not languageContent then
        print ("[Improved Neon Rims Controls]", "Language file for "..gameLang.." is missing, fallback translation is used!")
        languageContent =
        {
            SettingsTabTitle = "Improved Neon Rims Controls",
            MainCategoryTitle = "Improved Neon Rims Controls - General",
            BikesCategoryTitle = "Improved Neon Rims Controls - Bikes only",
            HeadlightsCategoryTitle = "Improved Neon Rims Controls - Headlights extra",
            HotkeyTitle = "Neon Rims Toggle Key",
            HotkeyDescription = "Key to toggle neon rims on and off",
            SwitchOnBikeTitle = "Turn neon rims on when getting on a bike",
            SwitchOnBikeDesc = "By game default, neon rims are only on when you press the defined button while on a bike. This settings turns neon rims automatically on when getting on a bike.",
            SwitchOffBikeTitle = "Turn neon rims on when getting off a bike",
            SwitchOffBikeDesc = "By game default, all lights are turned off when leaving any vehicle. This settings turns neon rims automatically on when getting off a bike.",
            ApplyOnlyOnBikesTitle = "Apply the above settings only for actual neon rims",
            ApplyOnlyOnBikesDesc = "By default, all lights referred as \"utility\" are controlled with this mod (e.g. neon rims, police car siren lights). If this setting is enabled, only the actual neon rims on the bike will be controlled.",
            ApplyToggleOnlyOnBikesTitle = "The neon rims toggle (Hotkey 0) only works for actual neon rims",
            ApplyToggleOnlyOnBikesDesc = "By default, all lights referred as \"utility\" are controlled with this mod (e.g. neon rims, police car siren lights). If this setting is enabled, the toggle hotkey will only work for actual neon rims.",
            TurnHeadlightsOnTitle = "Turn headlights on when getting off a bike",
            TurnHeadlightsOnDesc = "IMPORTANT: The settings from the 'Bike only' category are also applied here.",
            ToggleHeadlightsTitle = "Toggle headlights and neon rims at the same time",
            ToggleHeadlightsDesc = "IMPORTANT: The settings from the 'Bike only' category are also applied here."
        }
    end

    return languageContent
end

return Utilities