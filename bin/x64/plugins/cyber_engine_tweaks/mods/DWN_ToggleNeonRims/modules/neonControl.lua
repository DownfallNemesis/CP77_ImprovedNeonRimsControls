NeonControl = {}

function NeonControl.InitNeonControls()
    Observe("PlayerPuppet", "OnAction", function(_, action)    
        if DWN_ToggleNeonRims.scriptLogic.playerLeftCar and DWN_ToggleNeonRims.settings.turnOnWhenExit then
            DWN_ToggleNeonRims.scriptLogic.playerLeftCar = false
            DWN_ToggleNeonRims.scriptLogic.isNeonOn = true
            DWN_ToggleNeonRims.scriptObjects.vehicleController:ToggleLights(true, vehicleELightType.Utility)
            if DWN_ToggleNeonRims.settings.turnHeadlightsOn then  -- Extra option to turn headlights on too
                if DWN_ToggleNeonRims.settings.applyOnlyOnBikes and not Utilities.IsValueInArray(DWN_ToggleNeonRims.scriptObjects.bikeNameArray, DWN_ToggleNeonRims.scriptObjects.vehicleName) then
                else
                    DWN_ToggleNeonRims.scriptObjects.vehicleController:ToggleLights(true, vehicleELightType.Head)
                    DWN_ToggleNeonRims.scriptLogic.isHeadlightOn = true
                end
            end
        else
            DWN_ToggleNeonRims.scriptLogic.playerLeftCar = false
        end
    end)

    Observe("ExitingEvents", "OnEnter", function()
        DWN_ToggleNeonRims.scriptLogic.playerInCar = false
        DWN_ToggleNeonRims.scriptLogic.isNeonOn = false
        DWN_ToggleNeonRims.scriptLogic.isHeadlightOn = true -- To ensure neon rims and headlight lights state is the same
    end)

    ObserveAfter("ExitingEvents", "OnExit", function()
        DWN_ToggleNeonRims.scriptLogic.playerLeftCar = true;
    end)

    Observe("DriveEvents", "OnEnter", function()
        DWN_ToggleNeonRims.scriptObjects.vehicleController = Game.GetMountedVehicle(GetPlayer()):GetVehicleComponent():GetVehicleController()
        DWN_ToggleNeonRims.scriptObjects.vehicleName = DWN_ToggleNeonRims.Utilities.GetVehicleName()
        DWN_ToggleNeonRims.scriptObjects.vehicleController:ToggleLights(false, vehicleELightType.Head)

        if DWN_ToggleNeonRims.settings.applyOnlyOnBikes and not Utilities.IsValueInArray(DWN_ToggleNeonRims.scriptObjects.bikeNameArray, DWN_ToggleNeonRims.scriptObjects.vehicleName) then
        else
            if DWN_ToggleNeonRims.settings.turnOnWhenEnter then
                DWN_ToggleNeonRims.scriptObjects.vehicleController:ToggleLights(true, vehicleELightType.Utility)
                DWN_ToggleNeonRims.scriptLogic.isNeonOn = true
            else
                DWN_ToggleNeonRims.scriptObjects.vehicleController:ToggleLights(false, vehicleELightType.Utility)
                DWN_ToggleNeonRims.scriptLogic.isNeonOn = false;
            end
        end
        DWN_ToggleNeonRims.scriptLogic.playerInCar = true
    end)

    if Game.GetMountedVehicle(GetPlayer()) then
        DWN_ToggleNeonRims.scriptObjects.vehicleController = Game.GetMountedVehicle(GetPlayer()):GetVehicleComponent():GetVehicleController()
        DWN_ToggleNeonRims.scriptObjects.vehicleName = DWN_ToggleNeonRims.Utilities.GetVehicleName()
        DWN_ToggleNeonRims.scriptLogic.playerInCar = true
    end
end

function NeonControl.ToggleNeons()
    if DWN_ToggleNeonRims.scriptLogic.isNeonOn == true then
        DWN_ToggleNeonRims.scriptObjects.vehicleController:ToggleLights(false, vehicleELightType.Utility)
    else
        DWN_ToggleNeonRims.scriptObjects.vehicleController:ToggleLights(true, vehicleELightType.Utility)
    end
    DWN_ToggleNeonRims.scriptLogic.isNeonOn = not DWN_ToggleNeonRims.scriptLogic.isNeonOn

    -- Extra option to toggle headlights with neon rims
    if DWN_ToggleNeonRims.settings.toggleHeadlights then
        if DWN_ToggleNeonRims.scriptLogic.isHeadlightOn == true then
            DWN_ToggleNeonRims.scriptObjects.vehicleController:ToggleLights(false, vehicleELightType.Head)
        else
            DWN_ToggleNeonRims.scriptObjects.vehicleController:ToggleLights(true, vehicleELightType.Head)
        end
        DWN_ToggleNeonRims.scriptLogic.isHeadlightOn = not DWN_ToggleNeonRims.scriptLogic.isHeadlightOn
    end
end

return NeonControl