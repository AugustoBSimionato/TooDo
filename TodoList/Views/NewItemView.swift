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
            Text("Nova tarefa")
                .padding(.top, 30)
                .font(.system(size: 23))
                .bold()
            
            Form {
                TextField("Descreva a tarefa...", text: $viewModel.title)
                DatePicker("", selection: $viewModel.dueDate, in: Date()...)
                    .datePickerStyle(.graphical)
            }
            .scrollDisabled(true)
            .scrollContentBackground(.hidden)
            .shadow(radius: 5)
            
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
            .shadow(color: .accentColor.opacity(0.8), radius: 5)
            .padding(.bottom, 40)
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("Estranho...🤨"), message: Text("Acho que você esqueceu de descrever a tarefa, dê uma olhada!"))
            }
        }
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
