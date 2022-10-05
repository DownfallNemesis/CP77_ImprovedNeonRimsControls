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
    }
}

function DWN_ToggleNeonRims:new()
    registerForEvent("onInit", function()

        LoadUserSettings()
        SetupSettingsMenu()

        Observe("PlayerPuppet", "OnAction", function(_, action)
            if self.scriptLogic.playerLeftCar and self.settings.turnOnWhenExit then
                self.scriptLogic.playerLeftCar = false
                self.scriptLogic.isNeonOn = true
                self.scriptObjects.vehicleController:ToggleLights(true, vehicleELightType.Utility)
            else
                self.scriptLogic.playerLeftCar = false
            end

            if not self.scriptLogic.playerInCar and self.scriptObjects.vehicleController then
                local actionName = Game.NameToString(action:GetName(action))
                local actionType = action:GetType(action).value

                if actionName == self.settings.toggleKey then
                    if actionType == 'BUTTON_PRESSED' then
                        if self.scriptLogic.isNeonOn == true then
                            self.scriptObjects.vehicleController:ToggleLights(false, vehicleELightType.Utility)
                        else
                            self.scriptObjects.vehicleController:ToggleLights(true, vehicleELightType.Utility)
                        end
                        self.scriptLogic.isNeonOn = not self.scriptLogic.isNeonOn
                    end
                end
            end
        end)

        Observe("ExitingEvents", "OnEnter", function()
            self.scriptLogic.playerInCar = false
            self.scriptLogic.isNeonOn = false
        end)

        ObserveAfter("ExitingEvents", "OnExit", function()
            self.scriptLogic.playerLeftCar = true;
        end)

        Observe("DriveEvents", "OnEnter", function()
            self.scriptObjects.vehicleController = Game.GetMountedVehicle(GetPlayer()):GetVehicleComponent():GetVehicleController()

            if self.settings.turnOnWhenEnter then
                self.scriptObjects.vehicleController:ToggleLights(true, vehicleELightType.Utility)
                self.scriptLogic.isNeonOn = true
            else
                self.scriptObjects.vehicleController:ToggleLights(false, vehicleELightType.Utility)
                self.scriptLogic.isNeonOn = false;
            end
            self.scriptLogic.playerInCar = true
        end)

        if Game.GetMountedVehicle(GetPlayer()) then
            self.scriptObjects.vehicleController = Game.GetMountedVehicle(GetPlayer()):GetVehicleComponent():GetVehicleController()
            self.scriptLogic.playerInCar = true
        end
    end)
end

function SetupSettingsMenu()
    local nativeSettings = GetMod("nativeSettings")
    if not nativeSettings then
        print("Error: NativeSettings not found!")
        return
    end

    nativeSettings.addTab("/neon_rims_improvements", "Improved Neon Rims Controls")
    nativeSettings.addSubcategory("/neon_rims_improvements/cat", "Improved Neon Rims Controls")

    nativeSettings.addSwitch("/neon_rims_improvements/cat", "Turn neon rims on when getting on a bike", "Turn neon rims on when getting on a bike", DWN_ToggleNeonRims.settings.turnOnWhenEnter, true, function(state)
        DWN_ToggleNeonRims.settings.turnOnWhenEnter = state
        SaveUserSettings()
    end)

    nativeSettings.addSwitch("/neon_rims_improvements/cat", "Turn neon rims on when getting off a bike", "Turn neon rims on when getting off a bike", DWN_ToggleNeonRims.settings.turnOnWhenExit, true, function(state)
        DWN_ToggleNeonRims.settings.turnOnWhenExit = state
        SaveUserSettings()
    end)

    nativeSettings.refresh()
end

function LoadUserSettings()
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

function SaveUserSettings()
    local validJson, contents = pcall(function() return json.encode(DWN_ToggleNeonRims.settings) end)

    if validJson and contents ~= nil then
        local file = io.open("settings.json", "w+")
        file:write(contents)
        file:close()
    end
end

return DWN_ToggleNeonRims:new()