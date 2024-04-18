//
//  TimerView.swift
//  TomatoSauceTimer
//
//  Created by Wilsley Germano on 17/04/24.
//

import Foundation
import SwiftUI

struct TimerView: View {
    @StateObject private var controller = TimerController()
    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    
    var body: some View {
        ZStack {
            
            VStack(spacing: 8) {
               
                Text(controller.time)
                    .font(.custom("Exo", size: 50))
                
                HStack{
                    Button(controller.leftButtonTitle) {
                        timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
                        
                        if(controller.isPaused) {
                            controller.resumeTimer()
                            return
                        }
                        
                        controller.startTimer(minutes: 1, seconds: 0)
                    }
                    .disabled(controller.isRunning)
                    Button("Pause") {
                        timer.upstream.connect().cancel()
                        controller.pauseTimer()
                    }
                    .disabled(!controller.isRunning)
                }

                

            }
        }
        .padding()
        .onReceive(timer, perform: { _ in
            controller.updateTimer()
            print("Minutes: \(controller.durationMinutes)")
            print("Seconds: \(controller.durationSeconds)")
            if !controller.isRunning {
                timer.upstream.connect().cancel()
            }
        })
    }
}


#Preview {
    TimerView()
}
