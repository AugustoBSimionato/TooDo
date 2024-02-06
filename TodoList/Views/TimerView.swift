//
//  TimerView.swift
//  TodoList
//
//  Created by Augusto Simionato on 12/09/23.
//

import SwiftUI
import ActivityKit
import TipKit

struct timerTip: Tip {
    var title: Text = Text("title-tip3")
    var message: Text? = Text("message-tip3")
    var image: Image? = Image(systemName: "stopwatch.fill")
}

struct TimerView: View {
    @State private var isTrackingTime: Bool = false
    @State private var startTime: Date? = nil
    @State private var activity: Activity<TooDoWidgetsAttributes>? = nil
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.accent.opacity(0.1).ignoresSafeArea()
                
                VStack {
                    Spacer()
                    
                    if isTrackingTime {
                        if let startTime {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 200, height: 100)
                                    .foregroundColor(.accentColor)
                                    .opacity(0.2)
                                
                                VStack {
                                    Text(startTime, style: .timer)
                                        .foregroundColor(.accentColor)
                                        .font(.system(size: 50, weight: .semibold, design: .rounded))
                                }
                            }
                        }
                    } else {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 200, height: 100)
                                .foregroundColor(.accentColor)
                                .opacity(0.2)
                            
                            VStack {
                                Text("0:00")
                                    .foregroundColor(.accentColor)
                                    .font(.system(size: 50, weight: .semibold, design: .rounded))
                            }
                        }
                    }
                    
                    Spacer()
                        .frame(height: 100)
                    
                    Button {
                        isTrackingTime.toggle()
                        if isTrackingTime {
                            startTime = .now
                            
                            let attributes = TooDoWidgetsAttributes()
                            let state = TooDoWidgetsAttributes.ContentState(startTime: .now)
                            
                            activity = try? Activity<TooDoWidgetsAttributes>.request(attributes: attributes, contentState: state, pushType: nil)
                            
                            let impactMed = UIImpactFeedbackGenerator(style: .soft)
                            impactMed.impactOccurred()
                        } else {
                            guard let startTime else { return }
                            let state = TooDoWidgetsAttributes.ContentState(startTime: startTime)
                            
                            Task {
                                await activity?.end(using: state, dismissalPolicy: .immediate)
                            }
                            
                            self.startTime = nil
                            
                            let impactMed = UIImpactFeedbackGenerator(style: .soft)
                            impactMed.impactOccurred()
                        }
                    } label: {
                        ZStack {
                            Capsule(style: .continuous)
                                .frame(width: 220, height: 50)
                                .foregroundStyle(.firstViewText)
                            Text(isTrackingTime ? "zerar" : "começar")
                                .foregroundStyle(.firstViewForegroundButton)
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                        }
                    }
                    .popoverTip(timerTip())
                    
                    Spacer()
                }
                .padding()
                .navigationTitle("cronômetro")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
