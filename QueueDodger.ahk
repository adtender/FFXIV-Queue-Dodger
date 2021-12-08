; !!!!!! IF YOU HAVE TWO FACTOR AUTHENTICATION THIS WILL NOT WORK !!!!!!

; Recommend running in tandem with PiP-Tool, download here
; https://github.com/LionelJouin/PiP-Tool

; Needs FFXIVQuickLauncher to work, download here
; https://github.com/goatcorp/FFXIVQuickLauncher
; and on the launcher, check Log in automatically

quickLauncher = 1 ; Set to 0 if not using quickLauncher (not recommended, much slower!)

#SingleInstance Off
#Persistent
if not A_IsAdmin
{
   Run *RunAs "%A_ScriptFullPath%"
   ExitApp
}
#NoEnv
SendMode Input
SetTitleMatchMode, 2

Process Exist, ffxiv_dx11.exe
ProcessId := ErrorLevel
if (!ProcessId and quickLauncher = 1) ; QuickLauncher conditional
{
	Run C:\Users\WMPCw\AppData\Local\XIVLauncher\XIVLauncher.exe    ; Change to your location
    Sleep 5000
}

if (!ProcessId and quickLauncher = 0) ; Original Launcher conditional, Change Password-Text-Here to your password
{
	Run C:\FFXIV\FINAL FANTASY XIV - A Realm Reborn\boot\ffxivboot.exe    ; Change to your location
    Sleep 10000
	WinActivate ahk_exe ffxivlauncher.exe
	ControlClick x791 y350, ahk_exe ffxivlauncher.exe,,,, NA
	Send Password-Text-Here
	ControlClick x791 y485, ahk_exe ffxivlauncher.exe,,,, NA
	ControlClick x635 y640, ahk_exe ffxivlauncher.exe,,,, NA
	Sleep 7000
}

F1::SetAppVolume(ProcessId, 0)
F2::SetAppVolume(ProcessId, 100)

SetAppVolume(PID, MasterVolume)    ; WIN_V+
{
    MasterVolume := MasterVolume > 100 ? 100 : MasterVolume < 0 ? 0 : MasterVolume

    IMMDeviceEnumerator := ComObjCreate("{BCDE0395-E52F-467C-8E3D-C4579291692E}", "{A95664D2-9614-4F35-A746-DE8DB63617E6}")
    DllCall(NumGet(NumGet(IMMDeviceEnumerator+0)+4*A_PtrSize), "UPtr", IMMDeviceEnumerator, "UInt", 0, "UInt", 1, "UPtrP", IMMDevice, "UInt")
    ObjRelease(IMMDeviceEnumerator)

    VarSetCapacity(GUID, 16)
    DllCall("Ole32.dll\CLSIDFromString", "Str", "{77AA99A0-1BD6-484F-8BC7-2C654C9A9B6F}", "UPtr", &GUID)
    DllCall(NumGet(NumGet(IMMDevice+0)+3*A_PtrSize), "UPtr", IMMDevice, "UPtr", &GUID, "UInt", 23, "UPtr", 0, "UPtrP", IAudioSessionManager2, "UInt")
    ObjRelease(IMMDevice)

    DllCall(NumGet(NumGet(IAudioSessionManager2+0)+5*A_PtrSize), "UPtr", IAudioSessionManager2, "UPtrP", IAudioSessionEnumerator, "UInt")
    ObjRelease(IAudioSessionManager2)

    DllCall(NumGet(NumGet(IAudioSessionEnumerator+0)+3*A_PtrSize), "UPtr", IAudioSessionEnumerator, "UIntP", SessionCount, "UInt")
    Loop % SessionCount
    {
        DllCall(NumGet(NumGet(IAudioSessionEnumerator+0)+4*A_PtrSize), "UPtr", IAudioSessionEnumerator, "Int", A_Index-1, "UPtrP", IAudioSessionControl, "UInt")
        IAudioSessionControl2 := ComObjQuery(IAudioSessionControl, "{BFB7FF88-7239-4FC9-8FA2-07C950BE9C6D}")
        ObjRelease(IAudioSessionControl)

        DllCall(NumGet(NumGet(IAudioSessionControl2+0)+14*A_PtrSize), "UPtr", IAudioSessionControl2, "UIntP", ProcessId, "UInt")
        If (PID == ProcessId)
        {
            ISimpleAudioVolume := ComObjQuery(IAudioSessionControl2, "{87CE5498-68D6-44E5-9215-6DA47EF883D8}")
            DllCall(NumGet(NumGet(ISimpleAudioVolume+0)+3*A_PtrSize), "UPtr", ISimpleAudioVolume, "Float", MasterVolume/100.0, "UPtr", 0, "UInt")
            ObjRelease(ISimpleAudioVolume)
        }
        ObjRelease(IAudioSessionControl2)
    }
    ObjRelease(IAudioSessionEnumerator)
}

F3::
	$stop := 0
	Loop{
		Process Exist, ffxiv_dx11.exe
		ProcessId := ErrorLevel
		BlockInput MouseMove ; Block mouse movements for a fraction of a section to send inputs since mouse movement will switch back to M+K/B setup
		ControlSend, , {Blind}{Numpad0}, ahk_exe ffxiv_dx11.exe
		ControlSend, , {Blind}{Numpad0}, ahk_exe ffxiv_dx11.exe
		ControlSend, , {Blind}{Numpad0}, ahk_exe ffxiv_dx11.exe ; Three is the minimum number of actions for it to work continuously with mouse movement
		BlockInput MouseMoveOff 
		Sleep 1000
		If (!ProcessId and quickLauncher = 1) ; QuickLauncher conditional
		{
			Run C:\Users\WMPCw\AppData\Local\XIVLauncher\XIVLauncher.exe    ; Change to your location
			Sleep 10000
		}

		If (!ProcessId and quickLauncher = 0) ; Original Launcher conditional, Change Password-Text-Here to your password
		{
			Run C:\FFXIV\FINAL FANTASY XIV - A Realm Reborn\boot\ffxivboot.exe    ; Change to your location
			Sleep 10000
			WinActivate ahk_exe ffxivlauncher.exe
			ControlClick x791 y350, ahk_exe ffxivlauncher.exe,,,, NA
			Send Password-Text-Here
			ControlClick x791 y485, ahk_exe ffxivlauncher.exe,,,, NA
			ControlClick x635 y640, ahk_exe ffxivlauncher.exe,,,, NA
			Sleep 10000
		}		
		if ($stop)
		{
			return
		}
	}
F4:: $stop := 1
F9::ExitApp
