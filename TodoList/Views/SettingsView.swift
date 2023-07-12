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
    
    var body: some View {
        VStack {
            Text("Configurações")
                .padding(.top, 25)
                .font(.system(size: 25))
                .bold()
            
            Form {
                Section(header: Text("Notificações")) {
                    Toggle("Aviso de tarefa vencendo", isOn: $notifications)
                        .toggleStyle(SwitchToggleStyle(tint: Color("ButtonColor")))
                        .onTapGesture {
                            let impactHeavy = UIImpactFeedbackGenerator(style: .soft)
                            impactHeavy.impactOccurred()
                        }
                }
            }
            .scrollDisabled(true)
            .scrollContentBackground(.hidden)
            .shadow(radius: 2)
            
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

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(settingsPresented: Binding(get: {
            return true
        }, set: { _ in
            
        }))
    }
}
