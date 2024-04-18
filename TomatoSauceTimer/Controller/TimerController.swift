//
//  TimerController.swift
//  TomatoSauceTimer
//
//  Created by Wilsley Germano on 17/04/24.
//

import Foundation

class TimerController: ObservableObject {
    @Published var isRunning: Bool = false
    @Published var showAlert: Bool = false
    @Published var durationMinutes: Int = 0
    @Published var durationSeconds: Int = 0
    @Published var time: String = "0:00"
    @Published var isPaused: Bool = false
    @Published var leftButtonTitle: String = "Start"
    
    private var endDate = Date()
    
    func startTimer(minutes: Int, seconds: Int) {
        self.durationMinutes = minutes
        self.durationSeconds = seconds
        self.time = "\(self.durationMinutes):\(self.durationSeconds)"
        self.endDate = Date()
        self.isRunning = true
        self.showAlert = false
        self.isPaused = false
        let timerInSeconds: Int = (minutes * 60) + seconds
        self.endDate = Calendar.current.date(byAdding: .second, value: timerInSeconds, to: endDate)!
    }


    
    func resetTimer() {
        self.isRunning = false
        self.showAlert = false
        self.durationMinutes = 0
        self.durationSeconds = 0
        self.time = "0:00"
        self.isPaused = false
    }
    
    func pauseTimer() {
        if self.isRunning {
            self.isRunning = false
            self.isPaused = true
            self.leftButtonTitle = "Resume"
        }
    }
    
    func resumeTimer() {
        self.isPaused = false
        self.leftButtonTitle = "Start"
        startTimer(minutes: self.durationMinutes, seconds: self.durationSeconds)
        
    }
    
    func updateTimer() {
        guard isRunning else {
            return
        }
        
        let currentDate = Date()
        
        let remainingTime = endDate.timeIntervalSince1970 - currentDate.timeIntervalSince1970
        
        if remainingTime <= 0 {
            self.isRunning = false
            self.durationMinutes = 0
            self.durationSeconds = 0
            self.showAlert = true
            self.time = "0:00"
            self.isPaused = false
            return
        }
        
        let differenceInDate = Date(timeIntervalSince1970: remainingTime)
        let currentCalendar = Calendar.current
        self.durationMinutes = currentCalendar.component(.minute, from: differenceInDate)
        self.durationSeconds = currentCalendar.component(.second, from: differenceInDate)
        self.time = "\(self.durationMinutes):\(self.durationSeconds)"
    }
    
}
