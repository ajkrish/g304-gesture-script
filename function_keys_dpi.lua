function OnEvent(event, arg)
       if IsModifierPressed("lctrl") and arg == 6 and event == "MOUSE_BUTTON_PRESSED" then
        PlayMacro("DPI Cycle")
       end
	if arg == 6 and event == "MOUSE_BUTTON_PRESSED" then
		k = "f16"
		PressKey(k)
	end
	
	if arg == 6 and event == "MOUSE_BUTTON_RELEASED" then
		k = "f16"
		ReleaseKey(k)
	end
end