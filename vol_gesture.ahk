; Script settings
#SingleInstance, force
SetTitleMatchMode 2
DetectHiddenWindows, On

; Globals

global g_filter_aggression, g_m_sample_rate, _mx_diff, _my_diff, _mx_prev, _my_prev, _mx, _my, _mx_filter, _my_filter, g_slide_x, g_slide_y, g_slide_x_fast
; Time in ms between mouse position samples
g_m_sample_rate := 25


; Mouse movement filter aggression parameter. Parameter should be between 0 and 1. Higher values mean more aggressive smoothing and higher latency in registering changes in mouse movement speed. A value of zero effectively disables the filter.
g_filter_aggression := 0.1

; Distance between mouse sample positions, in pixels
_mx_diff := 0
_my_diff := 0

; Last saved mouse coordinates
_mx_prev := 0
_my_prev := 0

; Current mouse coordinates
_mx := 0
_my := 0

; Distance between mouse sample positions, in pixels, with smoothing applied
_mx_filter := 0
_my_filter := 0


; Functions
UpdateGestures() {
	; Get mouse coordinates
	MouseGetPos, _mx, _my

	; ToolTip % _mx ", " _my ", " _mx_prev ", " _my_prev ", " _mx_diff ", " _my_diff ", " _mx_filter ", " _my_filter
	; Distance between mouse sample positions, in pixels
	_mx_diff := _mx - _mx_prev
	_my_diff := _my_prev - _my

	; Set previous mouse coordinates to current
	_mx_prev := _mx
	_my_prev := _my

	; Smoothing for differential movements
	_mx_filter := ((_mx_filter * g_filter_aggression) + (_mx_diff * (1.0 - g_filter_aggression)))
	_my_filter := ((_my_filter * g_filter_aggression) + (_my_diff * (1.0 - g_filter_aggression)))

	; Gestures - Slide
	g_slide_x := ((Abs(_mx_filter) > (5 * (Abs(_my_filter)))) * _mx_diff)
	g_slide_y := ((Abs(_my_filter) > (5 * (Abs(_mx_filter)))) * _my_diff)

}

SideButtonEntry() {
	; Set previous coordinates to current coordinates to prevent errors in filtered coordinates
	MouseGetPos, _mx_prev, _my_prev

	UpdateGestures()
}

*f16::
SideButtonEntry()

while GetKeyState("f16", "P") {
	UpdateGestures()
	g_slide_x_fast := Ceil((Mod(Abs(g_slide_x),10)))
	;DebugMessage(g_slide_x_fast)
	;DebugMessage(g_slide_x)
		if(g_slide_x > 20) {
			Loop %g_slide_x_fast%{
			Send {Volume_Up}
			}
			Return
		}
		else if(g_slide_x >= 1 && g_slide_x <=20) {
			Loop 1{
			Send {Volume_Up}
			}
			Return
		}
		else if(g_slide_x <= -1 && g_slide_x >=-20) {
			Loop 1{
			Send {Volume_Down}
			}
			Return
		}
		else if(g_slide_x <-20) {
			Loop %g_slide_x_fast%{
			Send {Volume_Down}
			}
			Return
		}
	; Sample mouse movements at 20ms
	Sleep g_m_sample_rate
}
Return

DebugMessage(str)
{
 global h_stdout
 DebugConsoleInitialize()  ; start console window if not yet started
 str .= "`n" ; add line feed
 DllCall("WriteFile", "uint", h_Stdout, "uint", &str, "uint", StrLen(str), "uint*", BytesWritten, "uint", NULL) ; write into the console
 WinSet, Bottom,, ahk_id %h_stout%  ; keep console on bottom
}

DebugConsoleInitialize()
{
   global h_Stdout     ; Handle for console
   static is_open = 0  ; toogle whether opened before
   if (is_open = 1)     ; yes, so don't open again
     return
	 
   is_open := 1	
   ; two calls to open, no error check (it's debug, so you know what you are doing)
   DllCall("AttachConsole", int, -1, int)
   DllCall("AllocConsole", int)

   dllcall("SetConsoleTitle", "str","Paddy Debug Console")    ; Set the name. Example. Probably could use a_scriptname here 
   h_Stdout := DllCall("GetStdHandle", "int", -11) ; get the handle
   WinSet, Bottom,, ahk_id %h_stout%      ; make sure it's on the bottom
   WinActivate,Lightroom   ; Application specific; I need to make sure this application is running in the foreground. YMMV
   return
}

; Exit Script - Ctrl-Shift-Win-X
^+#x::ExitApp