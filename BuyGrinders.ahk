#Requires AutoHotkey v2.0
#Include BreakMessage.ahk

SHOP_BUTTON_STATUS := "SHOP BUTTON"
GRINDERS_PURCHASE_STATUS := "GRINDERS PURCHASE"

class GrindersBuyer {
    __New(targetWindow) {
        this.targetWindow := targetWindow
    }

    _LongRandomSleep() {
        randomTime := Random(1000, 1400)
        Sleep(randomTime)
    }
    
    _ShortRandomSleep() {
        randomTime := Random(450, 525)
        Sleep(randomTime)
    }

    _ConfirmGrinderPurchase(){
        ControlSend("{ENTER}", this.targetWindow)
        this._LongRandomSleep()
        ControlSend("{ENTER}", this.targetWindow)
        this._ShortRandomSleep()
        ControlSend("{ENTER}", this.targetWindow)
        this._LongRandomSleep()
    }

    _ToStorageMenu(){
        ControlSend("{Down}", this.targetWindow)
        this._ShortRandomSleep()
        ControlSend("{Down}", this.targetWindow)
        this._ShortRandomSleep()
        ControlSend("{Down}", this.targetWindow)
        this._ShortRandomSleep()
        ControlSend("{Down}", this.targetWindow)
        this._ShortRandomSleep()
        ControlSend("{Down}", this.targetWindow)
        this._ShortRandomSleep()
        ControlSend("{ENTER}", this.targetWindow)
        this._ShortRandomSleep()
    }

    _BulkSendMaterialStorage() {
        ControlSend("{Down}", this.targetWindow)
        this._ShortRandomSleep()
        ControlSend("{Down}", this.targetWindow)
        this._ShortRandomSleep()
        ControlSend("{ENTER}", this.targetWindow) ; Then, confirm send to material storage
        this._LongRandomSleep()
        ControlSend("{Left}", this.targetWindow)
        this._ShortRandomSleep()
        ControlSend("{ENTER}", this.targetWindow)
        this._ShortRandomSleep()
    }

    ; Basically, keep buying grinders until any of the state is invalid...
    ; (Usually occurs when material storage runs out of grinders...)
    BuyGrinders() {
        while (true) {
            ; Start by talking to Nysa
            ControlSend("e", this.targetWindow)
            Sleep(1500)

            ; Find the shop menu button on the screen...
            FoundX := 0
            FoundY := 0
            AttemptNumber := 0
            while (not ImageSearch(&FoundX, &FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, "*185 assets\buying\shop-menu-state.png")) {
                this._ShortRandomSleep()

                ; Failed to find the shop menu button in more than 3 attempts...
                if (AttemptNumber > 3) {
                    breakMsg := BreakMessage(SHOP_BUTTON_STATUS, "'Excube Exchange Shop' button not found!")
                    return breakMsg
                }
                AttemptNumber++
            }

            ; Enter excube exchange shop menu...
            ControlSend("{ENTER}", this.targetWindow)
            ; TODO: Replace with image reconigiton to be 'ready to set to 33' state,'
            ; Rather than rely on a random sleep....
            this._LongRandomSleep()
            this._LongRandomSleep()

            ; Set to maximum possible grinders to purchase
            ControlSend("{Left}", this.targetWindow)
            Sleep(1500)

            AttemptNumber := 0
            while (not ImageSearch(&FoundX, &FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, "*135 assets\buying\buy-state.png")) {
                this._ShortRandomSleep()

                if (AttemptNumber > 3) {
                    ; Most likely either due to grinders being too full in material storage,
                    ; or not enough excubes...
                    breakMsg := BreakMessage(GRINDERS_PURCHASE_STATUS, "Unable to use 33 excubes to buy grinders. Material Storage is likely to have full grinders capacity!")
                    return breakMsg
                }

                AttemptNumber++
            }

            this._ConfirmGrinderPurchase()

            ; Open storage and put all stuff in material storage...
            ControlSend("{Esc}", this.targetWindow)
            this._LongRandomSleep()

            this._ToStorageMenu()
            this._BulkSendMaterialStorage()

            ControlSend("{Esc}", this.targetWindow) ; Back to main menu
            this._LongRandomSleep()
            ControlSend("{Up}", this.targetWindow)
            this._ShortRandomSleep()
            ControlSend("{Up}", this.targetWindow)
            this._ShortRandomSleep()
            ControlSend("{Up}", this.targetWindow)
            this._ShortRandomSleep()
            ControlSend("{Up}", this.targetWindow)
            this._ShortRandomSleep()
            ControlSend("{Up}", this.targetWindow) ; Reset back to hover over 'Excube Exchange shop' button...
            this._ShortRandomSleep()
        }
    }
}