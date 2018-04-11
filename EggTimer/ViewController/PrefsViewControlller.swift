//
//  PrefsViewControlller.swift
//  EggTimer
//
//  Created by screson on 2018/4/11.
//  Copyright © 2018年 screson. All rights reserved.
//

import Cocoa

class PrefsViewControlller: NSViewController {
    
    var prefs = Preferences()

    @IBOutlet weak var presetsPopup: NSPopUpButton!
    @IBOutlet weak var customSlider: NSSlider!
    @IBOutlet weak var customTextField: NSTextField!
    @IBOutlet weak var playSoundCheckBoxx: NSButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        showExistingPrefs()
    }
    
    @IBAction func popupValueChanged(_ sender: NSPopUpButton) {
        if sender.selectedItem?.title == "Custom" {
            customSlider.isEnabled = true
            return
        }
        
        let newTimerDuration = sender.selectedTag()
        customSlider.integerValue = newTimerDuration
        showSliderValueAsText()
        customSlider.isEnabled = false
    }
    
    @IBAction func sliderValueChanged(_ sender: NSSlider) {
        showSliderValueAsText()
    }
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        view.window?.close()
    }
    
    @IBAction func okButtonClicked(_ sender: Any) {
        saveNewPrefs()
        view.window?.close()
    }
    
    @IBAction func checkBoxClicked(_ sender: NSButton) {
        if sender.state.rawValue == 0 {
            prefs.notPlaySound = true
        } else  {
            prefs.notPlaySound = false
        }
    }
    
    
    func showExistingPrefs() {
        let selectedTimeInMinutes = Int(prefs.selectedTime) / 60
        presetsPopup.selectItem(withTitle: "Custom")
        customSlider.isEnabled = true
        
        for item in presetsPopup.itemArray {
            if item.tag == selectedTimeInMinutes {
                presetsPopup.select(item)
                customSlider.isEnabled = false
                break
            }
        }
        
        customSlider.integerValue = selectedTimeInMinutes
        showSliderValueAsText()
        
        if prefs.notPlaySound {
            playSoundCheckBoxx.state = NSControl.StateValue(rawValue: 0)
        } else {
            playSoundCheckBoxx.state = NSControl.StateValue(rawValue: 1)
        }
    }
    
    func showSliderValueAsText() {
        let newTimerDuration = customSlider.integerValue
        let minutesDescription = (newTimerDuration == 1) ? "minute" : "minutes"
        customTextField.stringValue = "\(newTimerDuration) \(minutesDescription)"
    }
    
    func saveNewPrefs() {
        let alert = NSAlert()
        alert.messageText = "Reset Timer with the new settings?"
        alert.informativeText = "This will stop your current timer!"
        alert.alertStyle = .warning
        alert.addButton(withTitle: "Reset")
        alert.addButton(withTitle: "Cancel")
        let response = alert.runModal()
        if response == NSApplication.ModalResponse.alertFirstButtonReturn {
            prefs.selectedTime = customSlider.doubleValue * 60
            NotificationCenter.default.post(name: Notification.Name(rawValue: "PrefsChanged"), object: nil)
        }
    }
}
