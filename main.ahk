; AutoHotkey Version 2 Script

programid := WinGetList("PHANTASY STAR ONLINE 2 NEW GENESIS")
targetWindow := 0

; Find and focus on window
if (programid.Length > 0) {
    targetWindow := programid[1]
    WinActivate(targetWindow)
    Sleep(1000)
} else {
    MsgBox("Target program window not found. Exiting...")
    Sleep(5000)
    ExitApp()
}


FoundX := 0
FoundY := 0
; Perform image search across the entire screen
if (ImageSearch(&FoundX, &FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, "*155 assets\buying\shop-menu-state.png")) {
    MsgBox("Found Excube Exchange Shop Button at (" FoundX ", " FoundY ").")
} else {
    MsgBox("Found Excube Exchange Shop Button not found.")
}


ExitApp()