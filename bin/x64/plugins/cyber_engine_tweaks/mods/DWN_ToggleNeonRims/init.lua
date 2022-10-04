DWN_ToggleNeonRims = {
    settings = {
        toggleKey = "Keyboard_0"
    },

    scriptLogic = {
        playerInCar = false,
        isNeonOn = false
    },

    scriptObjects = {
        vehicleController = nil
    }
}

function DWN_ToggleNeonRims:new()
    registerForEvent("onInit", function()
        Observe('PlayerPuppet', 'OnAction', function(_, action)
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

        Observe("ExitingEvents", "OnEnter", function ()
            self.scriptLogic.playerInCar = false
            self.scriptLogic.isNeonOn = false
        end)

        Observe("DriveEvents", "OnEnter", function ()
            self.scriptObjects.vehicleController = Game.GetMountedVehicle(GetPlayer()):GetVehicleComponent():GetVehicleController()
            self.scriptObjects.vehicleController:ToggleLights(false, vehicleELightType.Utility)
            self.scriptLogic.playerInCar = true
        end)
    end)
end

return DWN_ToggleNeonRims:new()