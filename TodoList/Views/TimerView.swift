//
//  TimerView.swift
//  TodoList
//
//  Created by Augusto Simionato on 03/07/23.
//

import SwiftUI
import UserNotifications

struct TimerView: View {
    @State var start = false
    @State var to: CGFloat = 0
    @State var count = 0
    @State var time = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            VStack {
                ZStack {
                    Circle()
                        .trim(from: 0, to: 1)
                        .stroke(Color("Purple").opacity(0.25), style: StrokeStyle(lineWidth: 35, lineCap: .round))
                        .frame(width: 280, height: 280)
                    
                    Circle()
                        .trim(from: 0, to: self.to)
                        .stroke(Color("ButtonColor"), style: StrokeStyle(lineWidth: 35, lineCap: .round))
                        .frame(width: 280, height: 280)
                        .rotationEffect(.init(degrees: -90))
                }
                .padding(.bottom, 30)
                
                HStack(spacing: 20) {
                    Button(action: {
                        if self.count == 15 {
                            self.count = 0
                            
                            withAnimation {
                                self.to = 0
                            }
                        }
                        
                        self.start.toggle()
                    }) {
                        HStack(spacing: 15) {
                            Image(systemName: self.start ? "pause.fill" : "play.fill")
                                .foregroundColor(.white)
                            
                            Text(self.start ? "Pausar" : "Começar")
                                .foregroundColor(.white)
                        }
                        .padding(.vertical)
                        .frame(width: (UIScreen.main.bounds.width / 2) - 55)
                        .background(Color("ButtonColor"))
                        .clipShape(Capsule())
                        .shadow(radius: 6)
                    }
                    
                    Button(action: {
                        self.count = 0
                        
                        withAnimation {
                            self.to = 0
                        }
                        
                    }) {
                        HStack(spacing: 15) {
                            Image(systemName: "arrow.clockwise")
                                .foregroundColor(.accentColor)
                            
                            Text("Zerar")
                                .foregroundColor(.accentColor)
                        }
                        .padding(.vertical)
                        .frame(width: (UIScreen.main.bounds.width / 2) - 55)
                        .background(
                            Capsule()
                                .stroke(Color.accentColor, lineWidth: 2)
                        )
                    }
                }
                .padding(.top, 55)
            }
        }
        .navigationTitle("Timer")
        .navigationBarTitleDisplayMode(.inline)
        .onReceive(self.time) { (_) in
            if self.start {
                if self.count != 15 {
                    self.count += 1
                    print("\(self.count)")
                    
                    withAnimation {
                        self.to = CGFloat(self.count) / 15
                    }
                } else {
                    self.start.toggle()
                    Notify()
                }
            }
        }
    }
    
    func Notify() {
        let content = UNMutableNotificationContent()
        content.title = "TooDo"
        content.subtitle = "Timer finalizado! ⏲️"
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.25, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
