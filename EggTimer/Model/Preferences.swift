//
//  Preferences.swift
//  EggTimer
//
//  Created by screson on 2018/4/11.
//  Copyright © 2018年 screson. All rights reserved.
//

import Foundation

struct Preferences {
    var notPlaySound: Bool {
        get {
            let ps = UserDefaults.standard.integer(forKey: "notPlaySound")
            if ps == 1 {
                return true
            }
            return false
        }
        set {
            UserDefaults.standard.set(newValue ? 1 : 0, forKey: "notPlaySound")
            UserDefaults.standard.synchronize()
        }
    }
    var selectedTime: TimeInterval {
        get {
            let savedTime = UserDefaults.standard.double(forKey: "selectedTime")
            if savedTime > 0 {
                return savedTime
            }
            return 360
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "selectedTime")
            UserDefaults.standard.synchronize()
        }
    }
}
