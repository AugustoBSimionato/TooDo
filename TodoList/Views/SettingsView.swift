//
//  SettingsView.swift
//  TodoList
//
//  Created by Augusto Simionato on 22/06/23.
//

import SwiftUI

struct SettingsView: View {
    @Binding var settingsPresented: Bool
    
    @State private var notifications = false
    @State private var sports = false
    @State private var stepper = 1
    
    var body: some View {
        VStack {
            VStack {
                Spacer()
                
                VStack {
                    Form {
                        Section(header: Text("Notifications")) {
                            Toggle("Send Notifications", isOn: $notifications)
                                .toggleStyle(SwitchToggleStyle(tint: Color("ButtonColor")))
                                .onTapGesture {
                                    let impactHeavy = UIImpactFeedbackGenerator(style: .soft)
                                    impactHeavy.impactOccurred()
                                }
                        }
                        
                        Section(header: Text("Newsletter settings")) {
                            Toggle("Sports", isOn: $sports)
                                .toggleStyle(SwitchToggleStyle(tint: Color("ButtonColor")))
                            Stepper("Notifications per day: \(stepper)", value: $stepper) {_ in
                                let impactMed = UIImpactFeedbackGenerator(style: .soft)
                                impactMed.impactOccurred()
                            }
                        }
                    }
                    .scrollDisabled(true)
                    .scrollContentBackground(.hidden)
                    .shadow(radius: 2)
                }
                
                Spacer()
                
                Button {
                    settingsPresented = false
                } label: {
                    Text("Salvar")
                        .font(.system(size: 18, weight: .medium))
                        .bold()
                        .foregroundColor(.white)
                        .frame(width: 150, height: 45)
                        .background {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color("ButtonColor"))
                        }
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(settingsPresented: Binding(get: {
            return true
        }, set: { _ in
            
        }))
    }
}
