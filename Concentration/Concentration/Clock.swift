//
//  Clock.swift
//  Concentration
//
//  Created by Jeson Rosario on 9/18/19.
//  Copyright © 2019 Jeson Rosario. All rights reserved.
//

import Foundation

class Clock {
    
    var time = 0
    var timer = Timer()
    
    @objc func incTime() {
        time += 1
    }
    
    func start() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector:#selector(incTime), userInfo: nil, repeats: true)
    }
    
    func reset() {
        timer.invalidate()
        time = 0
    }
    
}
