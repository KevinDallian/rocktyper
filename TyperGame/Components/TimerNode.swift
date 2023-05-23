//
//  TimerNode.swift
//  TyperGame
//
//  Created by Kevin Dallian on 23/05/23.
//

import Foundation
import SpriteKit

class TimerNode: SKLabelNode {
    var startTime: TimeInterval = 0
    var currentTime: TimeInterval = 0
    var isTimerRunning = false
    var timeIsUp = false
    
    func startTimer() {
        startTime = Date.timeIntervalSinceReferenceDate
        isTimerRunning = true
    }
    
    func timerIdle(){
        text = String(format: "%02d", 30)
    }
    
    func stopTimer() {
        isTimerRunning = false
    }
    
    func updateTimer() {
        guard isTimerRunning else {
            return
        }
        
        currentTime = Date.timeIntervalSinceReferenceDate - startTime
        let remainingTime = max(30 - currentTime, 0)
        let seconds = Int(remainingTime) % 30
        text = String(format: "%02d", seconds)
        
        if remainingTime <= 0 {
            stopTimer()
            timeIsUp = true
        }
    }
}

