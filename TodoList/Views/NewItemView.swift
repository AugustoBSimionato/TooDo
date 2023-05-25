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
    
    var body: some View {
        VStack {
            Text("New Item")
                .padding()
                .font(.system(size: 32))
                .bold()
            
            Form {
//              Title
                TextField("Title", text: $viewModel.title)
                
//              Due Date
                DatePicker("Due Date", selection: $viewModel.dueDate)
                    .datePickerStyle(.graphical)
                
//              Button
                TLButton(title: "Save", background: .pink) {
                    if viewModel.canSave {
                        viewModel.save()
                        newItemPresented = false
                    } else {
                        viewModel.showAlert = true
                    }
                }
                .padding()
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("Error"), message: Text("Please fill all fields ans select a due date that is today or newer"))
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
