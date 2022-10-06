neonControl = {}

function neonControl.InitNeonControls(mod) -- mod = DWN_ToggleNeonRims
    Observe("PlayerPuppet", "OnAction", function(_, action)
        if mod.scriptLogic.playerLeftCar and mod.settings.turnOnWhenExit then
            mod.scriptLogic.playerLeftCar = false
            mod.scriptLogic.isNeonOn = true
            mod.scriptObjects.vehicleController:ToggleLights(true, vehicleELightType.Utility)
        else
            mod.scriptLogic.playerLeftCar = false
        end

        if not mod.scriptLogic.playerInCar and mod.scriptObjects.vehicleController then
            local actionName = Game.NameToString(action:GetName(action))
            local actionType = action:GetType(action).value

            if actionName == mod.settings.toggleKey then
                if actionType == 'BUTTON_PRESSED' then
                    if mod.scriptLogic.isNeonOn == true then
                        mod.scriptObjects.vehicleController:ToggleLights(false, vehicleELightType.Utility)
                    else
                        mod.scriptObjects.vehicleController:ToggleLights(true, vehicleELightType.Utility)
                    end
                    mod.scriptLogic.isNeonOn = not mod.scriptLogic.isNeonOn
                end
            end
        end
    end)

    Observe("ExitingEvents", "OnEnter", function()
        mod.scriptLogic.playerInCar = false
        mod.scriptLogic.isNeonOn = false
    end)

    ObserveAfter("ExitingEvents", "OnExit", function()
        mod.scriptLogic.playerLeftCar = true;
    end)

    Observe("DriveEvents", "OnEnter", function()
        mod.scriptObjects.vehicleController = Game.GetMountedVehicle(GetPlayer()):GetVehicleComponent():GetVehicleController()

        if mod.settings.turnOnWhenEnter then
            mod.scriptObjects.vehicleController:ToggleLights(true, vehicleELightType.Utility)
            mod.scriptLogic.isNeonOn = true
        else
            mod.scriptObjects.vehicleController:ToggleLights(false, vehicleELightType.Utility)
            mod.scriptLogic.isNeonOn = false;
        end
        mod.scriptLogic.playerInCar = true
    end)

    if Game.GetMountedVehicle(GetPlayer()) then
        mod.scriptObjects.vehicleController = Game.GetMountedVehicle(GetPlayer()):GetVehicleComponent():GetVehicleController()
        mod.scriptLogic.playerInCar = true
    end
end

return neonControl