//
//  NewItemView.swift
//  TodoList
//
//  Created by Augusto Simionato on 19/05/23.
//

import SwiftUI

struct NewItemView: View {
    @StateObject var viewModel = NewItemViewViewModel()
    @Binding var newItemPresented: Bool
    
    let notify = NewItemViewViewModel()
    
    var body: some View {
        VStack {
            Form {
                TextField("Descreva a tarefa...", text: $viewModel.title)
                DatePicker("", selection: $viewModel.dueDate, in: Date()...)
                    .datePickerStyle(.graphical)
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
                        notify.sendScheduleNotification(date: viewModel.dueDate, title: "Já finalizou essa tarefa? 🤔", body: viewModel.title)
                        newItemPresented = false
                    } else {
                        viewModel.showAlert = true
                    }
                } label: {
                    Text("Adicionar")
                        .foregroundColor(.white)
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                }
            }
            .padding(.bottom, 40)
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("Estranho...🤨"), message: Text("Acho que você esqueceu de descrever a tarefa, dê uma olhada!"))
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
