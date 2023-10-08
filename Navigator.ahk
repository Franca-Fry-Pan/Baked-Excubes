#Requires AutoHotkey v2.0

class Navigator {
    __New(targetWindow) {
        this.targetWindow := targetWindow
    }

    _ShortRandomSleep() {
        randomTime := Random(200, 250)
        Sleep(randomTime)
    }

    MoveToSellGrinders() { 
        ControlSend("{s down}", this.targetWindow)
        Sleep(5500)
        ControlSend("{s up}", this.targetWindow)
        ; Should be beside the potted plant now...
        this._ShortRandomSleep()

        ControlSend("{d down}", this.targetWindow)
        Sleep(9000)
        ControlSend("{d up}", this.targetWindow)
        ; Should be beside the casino now.
        this._ShortRandomSleep()

        ControlSend("{a down}", this.targetWindow)
        Sleep(3900)
        ControlSend("{a up}", this.targetWindow)
        ; Should be at the fountain
        this._ShortRandomSleep()

        ControlSend("{w down}", this.targetWindow)
        Sleep(5500)
        ControlSend("{w up}", this.targetWindow)
        ; Should be at the shop now...
        this._ShortRandomSleep()
    }
}
