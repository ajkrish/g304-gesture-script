# g304-gesture-script

# Logitech G Mouse Gestures
 An AutoHotKey script for performing actions based on mouse gestures combined with the side buttons on Logitech mice.

## Mappings
 G6(dpi key): Click G6 and slide left/right to change volume. Use ctrl+G6 to use dpi cycle.

## Setup
Add the lua script to ghub profile. Compile the .ahk file to .exe using AHK software. Put the .exe in windows startup folder.

!!!!Create a DPI Cycle Macro in Ghub software for dpi cycle to work.

# References

GHUB has built in docs for lua scripting.

https://bitbucket.org/EyeAmGroot/logitech-g-mouse-gestures/src/main/ Main code modified for for the script. This uses virtual function keys in lua script and then various gestures defined in ahk script.

https://stackoverflow.com/questions/69939845/logitech-dpi-shift-using-modifier Some code specifying how to use lua scripits

https://github.com/mark-vandenberg/g-hub-mouse-gestures For using Mac gestures in ghub(not used).

https://github.com/jehillert/logitech-ghub-lua-cheatsheet Lua cheatsheet

https://www.autohotkey.com/boards/viewtopic.php?p=490620#p490620 Different way to control volume along with ahk cusotm gui impelementation to show volume levels


## Emergency Exit
 To quit the AutoHotKey script at any time, use the keyboard combo `LCtrl-LShift-LWin-X`.
