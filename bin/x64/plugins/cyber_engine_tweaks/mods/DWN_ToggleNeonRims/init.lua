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

        settingsMenu.LoadUserSettings(self)
        settingsMenu.SetupMenu(self)
        neonControl.InitNeonControls(self)
        self.scriptObjects.bikeNameArray = utilities.ReadBikeNames()
    end)
end

return DWN_ToggleNeonRims:new()