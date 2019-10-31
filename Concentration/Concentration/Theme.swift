//
//  Theme.swift
//  Concentration
//
//  Created by Jeson Rosario on 9/18/19.
//  Copyright © 2019 Jeson Rosario. All rights reserved.
//

import Foundation

enum Theme: Int {
    case halloweenTheme, animalTheme, foodTheme, sportsTheme, faceTheme, vehicleTheme
    
    private static var _counter: Int {
        var num = 0
        while let _ = Theme(rawValue: num) {
            num += 1
        }
        return num
    }
    
    func themeChooser() -> String {
        switch self {
        case.halloweenTheme:
            return "👻🎃☠️😈😱🙀🧟‍♂️🕸🍭"
            
        case.animalTheme:
            return "🐶🐱🐰🦊🐼🦁🐒🦄🐷"
            
        case.foodTheme:
            return "🌭🍔🍟🍕🌮🌯🥓🍩🍦"
            
        case.sportsTheme:
            return "⚽️🏀🏈⚾️🎾🏐🥊🤺🥋"
            
        case.faceTheme:
            return "😀😍🥳🤠👨🏽‍🦳👨🏼‍🚀🎅🏽💂🏽‍♀️🧜🏽‍♀️"
            
        case.vehicleTheme:
            return "🚗🏎🚌🚑🚒🚀🛸🛩🛥"
        }
    }
    
}
