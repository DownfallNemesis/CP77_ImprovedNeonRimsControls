DWN_ToggleNeonRims = {
    settings = {
        toggleKey = "IK_0",
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

    NeonControl = require("modules/NeonControl"),
    SettingsMenu = require("modules/SettingsMenu"),
    Utilities = require("modules/Utilities"),
    InputManager = require("modules/InputManager")
}

function DWN_ToggleNeonRims:new()
    registerForEvent("onInit", function()
        -- Required codeware for the inputs
        if not Codeware then
            print("[Improved Neon Rims Control] Error: Missing Codeware")
        end
        
        SettingsMenu.LoadUserSettings()
        SettingsMenu.SetupMenu()
        InputManager.onInit()
        NeonControl.InitNeonControls()
        self.scriptObjects.bikeNameArray = Utilities.ReadBikeNames()
    end)

    registerForEvent("onShutdown", function ()
        InputManager.onShutdown()
    end)
end

return DWN_ToggleNeonRims:new()