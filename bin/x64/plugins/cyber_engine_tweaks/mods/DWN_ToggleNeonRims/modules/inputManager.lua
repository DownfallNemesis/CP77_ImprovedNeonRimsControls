InputManager = {
    listeningKeybindWidget = nil,
    inputListener = nil
}

local function handleInput(event)
    local key = event:GetKey().value
    local action = event:GetAction().value

    if InputManager.listeningKeybindWidget and key:find("IK_Pad") and action == "IACT_Release" then -- OnKeyBindingEvent has to be called manually for gamepad inputs, while there is a keybind widget listening for input
        InputManager.listeningKeybindWidget:OnKeyBindingEvent(KeyBindingEvent.new({keyName = key}))
        InputManager.listeningKeybindWidget = nil
    elseif InputManager.listeningKeybindWidget and action == "IACT_Release" then -- Key was bound, by keyboard
        InputManager.listeningKeybindWidget = nil
    end

    if action == "IACT_Release" then
        if key == DWN_ToggleNeonRims.settings.toggleKey then
            DWN_ToggleNeonRims.NeonControl.ToggleNeons()
        end
    end
end

function InputManager.onInit()
    Observe("SettingsSelectorControllerKeyBinding", "ListenForInput", function(this) -- A keybind widget is listening for input, so should we (Since gamepad inputs are not sent to the native OnKeyBindingEvent by default)
        InputManager.listeningKeybindWidget = this
    end)

    InputManager.inputListener = NewProxy({
        OnKeyInput = { -- https://github.com/psiberx/cp2077-codeware/wiki#game-events
            args = {'whandle:KeyInputEvent'},
            callback = handleInput
        }
    })

    ObserveBefore("PlayerPuppet", "OnGameAttached", function()
        Game.GetCallbackSystem():UnregisterCallback("Input/Key", InputManager.inputListener:Target())
        Game.GetCallbackSystem():RegisterCallback("Input/Key", InputManager.inputListener:Target(), InputManager.inputListener:Function("OnKeyInput"))
    end)

    ObserveBefore("PlayerPuppet", "OnDetach", function()
        Game.GetCallbackSystem():UnregisterCallback("Input/Key", InputManager.inputListener:Target())
    end)

    Game.GetCallbackSystem():RegisterCallback("Input/Key", InputManager.inputListener:Target(), InputManager.inputListener:Function("OnKeyInput"))
end

function InputManager.onShutdown()
    Game.GetCallbackSystem():UnregisterCallback("Input/Key", InputManager.inputListener:Target())
end

return InputManager