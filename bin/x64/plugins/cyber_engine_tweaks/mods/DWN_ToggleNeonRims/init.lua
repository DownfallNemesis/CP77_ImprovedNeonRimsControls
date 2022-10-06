DWN_ToggleNeonRims = {
    settings = {
        toggleKey = "Keyboard_0",
        turnOnWhenEnter = true,
        turnOnWhenExit = true,
    },

    scriptLogic = {
        playerInCar = false,
        playerLeftCar = false,
        isNeonOn = false
    },

    scriptObjects = {
        vehicleController = nil
    },

    neonControl = require("modules/neonControl"),
    settingsMenu = require("modules/settingsMenu"),
    languageLoader = require("modules/languageLoader")
}

function DWN_ToggleNeonRims:new()
    registerForEvent("onInit", function()

        settingsMenu.LoadUserSettings(self)
        settingsMenu.SetupMenu(self)
        neonControl.InitNeonControls(self)
    end)
end

return DWN_ToggleNeonRims:new()