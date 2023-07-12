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
            
            TLButton(title: "Adicionar") {
                if viewModel.canSave {
                    viewModel.save()
                    notify.sendScheduleNotification(date: viewModel.dueDate, title: "Já finalizou essa tarefa? 🤔", body: viewModel.title)
                    newItemPresented = false
                } else {
                    viewModel.showAlert = true
                }
            }
            .frame(width: 200, height: 80)
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("Estranho...🤨"), message: Text("Alguma coisa está faltando, dê uma olhada"))
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
