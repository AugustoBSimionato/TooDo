//
//  NewItemView.swift
//  TodoList
//
//  Created by Augusto Simionato on 19/05/23.
//

import SwiftUI
import TipKit

struct reminderDateTip: Tip {
    var title: Text = Text("Criando uma nova tarefa")
    var message: Text? = Text("Adicione uma descrição simples e uma data e hora para ser lembrado sobre essa tarefa")
    var image: Image? = Image(systemName: "calendar.badge.clock")
}

struct NewItemView: View {
    @StateObject var viewModel = NewItemViewViewModel()
    @Binding var newItemPresented: Bool
    
    let notify = NewItemViewViewModel()
    
    var body: some View {
        VStack {
            Form {
                TextField("descreva-a-tarefa...", text: $viewModel.title)
                DatePicker("", selection: $viewModel.dueDate, in: Date()...)
                    .datePickerStyle(.graphical)
                    .popoverTip(reminderDateTip())
            }
            .shadow(radius: 5)
            .scrollDisabled(true)
            .scrollContentBackground(.hidden)
            
            ZStack {
                Rectangle()
                    .foregroundColor(.clear)
                    .background(Color.accentColor)
                    .frame(width: 250, height: 50)
                    .cornerRadius(16)
                
                Button {
                    if viewModel.canSave {
                        viewModel.save()
                        notify.sendScheduleNotification(date: viewModel.dueDate, title: "já-finalizou-essa-tarefa?-🤔", body: viewModel.title)
                        newItemPresented = false
                        
                        let impactMed = UIImpactFeedbackGenerator(style: .soft)
                        impactMed.impactOccurred()
                    } else {
                        viewModel.showAlert = true
                    }
                } label: {
                    Text("adicionar")
                        .foregroundColor(.white)
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                }
            }
            .padding(.bottom, 40)
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("estranho...🤨"), message: Text("acho-que-você-esqueceu-de-descrever-a-tarefa,da-uma-olhada!"))
            }
        }
        .padding(.top, 30)
        .ignoresSafeArea(.keyboard)
    }
}

struct NewItemView_Previews: PreviewProvider {
    static var previews: some View {
        NewItemView(newItemPresented: Binding(get: {
            return true
        }, set: { _ in
            
        }))
    }
}
