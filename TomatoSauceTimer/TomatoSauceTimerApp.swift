//
//  TomatoSauceTimerApp.swift
//  TomatoSauceTimer
//
//  Created by Wilsley Germano on 17/04/24.
//

import SwiftUI

@main
struct UtilityApp: App {
    var body: some Scene {
        
        MenuBarExtra("Utility App", systemImage: "hammer") {
             TimerView()
         }
        .menuBarExtraStyle(.window)
        .keyboardShortcut("y", modifiers: [.shift, .control])
        
    }
}
