neonControl = {}

function neonControl.InitNeonControls(mod) -- mod = DWN_ToggleNeonRims
    Observe("PlayerPuppet", "OnAction", function(_, action)
        if mod.scriptLogic.playerLeftCar and mod.settings.turnOnWhenExit then
            mod.scriptLogic.playerLeftCar = false
            mod.scriptLogic.isNeonOn = true
            mod.scriptObjects.vehicleController:ToggleLights(true, vehicleELightType.Utility)
            if mod.settings.turnHeadlightsOn then  -- Extra option to turn headlights on too
                if mod.settings.applyOnlyOnBikes and not utilities.IsValueInArray(mod.scriptObjects.bikeNameArray, mod.scriptObjects.vehicleName) then
                else
                    mod.scriptObjects.vehicleController:ToggleLights(true, vehicleELightType.Head)
                    mod.scriptLogic.isHeadlightOn = true
                end
            end
        else
            mod.scriptLogic.playerLeftCar = false
        end

        if not mod.scriptLogic.playerInCar and mod.scriptObjects.vehicleController then
            local actionName = Game.NameToString(action:GetName(action))
            local actionType = action:GetType(action).value

            if actionName == mod.settings.toggleKey then
                if mod.settings.applyToggleOnlyOnBikes and not utilities.IsValueInArray(mod.scriptObjects.bikeNameArray, mod.scriptObjects.vehicleName) then
                    return
                else
                    if actionType == 'BUTTON_PRESSED' then
                        if mod.scriptLogic.isNeonOn == true then
                            mod.scriptObjects.vehicleController:ToggleLights(false, vehicleELightType.Utility)
                        else
                            mod.scriptObjects.vehicleController:ToggleLights(true, vehicleELightType.Utility)
                        end
                        mod.scriptLogic.isNeonOn = not mod.scriptLogic.isNeonOn

                        -- Extra option to toggle headlights with neon rims
                        if mod.settings.toggleHeadlights then
                            if mod.scriptLogic.isHeadlightOn == true then
                                mod.scriptObjects.vehicleController:ToggleLights(false, vehicleELightType.Head)
                            else
                                mod.scriptObjects.vehicleController:ToggleLights(true, vehicleELightType.Head)
                            end
                            mod.scriptLogic.isHeadlightOn = not mod.scriptLogic.isHeadlightOn
                        end
                    end
                end
            end
        end
    end)

    Observe("ExitingEvents", "OnEnter", function()
        mod.scriptLogic.playerInCar = false
        mod.scriptLogic.isNeonOn = false
        mod.scriptLogic.isHeadlightOn = true -- To ensure neon rims and headlight lights state is the same
    end)

    ObserveAfter("ExitingEvents", "OnExit", function()
        mod.scriptLogic.playerLeftCar = true;
    end)

    Observe("DriveEvents", "OnEnter", function()
        mod.scriptObjects.vehicleController = Game.GetMountedVehicle(GetPlayer()):GetVehicleComponent():GetVehicleController()
        mod.scriptObjects.vehicleName = mod.utilities.GetVehicleName()
        mod.scriptObjects.vehicleController:ToggleLights(false, vehicleELightType.Head)

        if mod.settings.applyOnlyOnBikes and not utilities.IsValueInArray(mod.scriptObjects.bikeNameArray, mod.scriptObjects.vehicleName) then
        else
            if mod.settings.turnOnWhenEnter then
                mod.scriptObjects.vehicleController:ToggleLights(true, vehicleELightType.Utility)
                mod.scriptLogic.isNeonOn = true
            else
                mod.scriptObjects.vehicleController:ToggleLights(false, vehicleELightType.Utility)
                mod.scriptLogic.isNeonOn = false;
            end
        end
        mod.scriptLogic.playerInCar = true
    end)

    if Game.GetMountedVehicle(GetPlayer()) then
        mod.scriptObjects.vehicleController = Game.GetMountedVehicle(GetPlayer()):GetVehicleComponent():GetVehicleController()
        mod.scriptObjects.vehicleName = mod.utilities.GetVehicleName()
        mod.scriptLogic.playerInCar = true
    end
end

return neonControl