DWN_ToggleNeonRims = {
    settings = {
        toggleKey = "Keyboard_0",
        turnOnWhenEnter = true,
        turnOnWhenExit = true,
        applyOnlyOnBikes = false,
        applyToggleOnlyOnBikes = false,
        turnHeadlightsOn = false,
        toggleHeadlights = false
    },

    scriptLogic = {
        playerInCar = false,
        playerLeftCar = false,
        isNeonOn = false,
        isHeadlightOn = false
    },

    scriptObjects = {
        vehicleController = nil,
        vehicleName = nil,
        bikeNameArray = {}
    },

    folderPaths = {
        languageFolder = "languages/"
    },

    neonControl = require("modules/neonControl"),
    settingsMenu = require("modules/settingsMenu"),
    utilities = require("modules/utilities")
}

function DWN_ToggleNeonRims:new()
    registerForEvent("onInit", function()

        -- Codeware is required
        if not Codeware then
            print("[Improved Neon Rims Control] Error: Codeware not installed.")
        end

        SettingsMenu.LoadUserSettings(self)
        SettingsMenu.SetupMenu(self)
        NeonControl.InitNeonControls(self)
        self.scriptObjects.bikeNameArray = Utilities.ReadBikeNames()
    end)
end

return DWN_ToggleNeonRims:new()