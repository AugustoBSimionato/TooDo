//
//  RegisterView.swift
//  TodoList
//
//  Created by Augusto Simionato on 19/05/23.
//

import SwiftUI

struct RegisterView: View {
    @StateObject var viewModel = RegisterViewViewModel()
    
    var body: some View {
        VStack {
//          MARK: Header
            VStack {
                VStack {
                    Image("criando-conta")
                        .padding(.top)
                        .padding(.bottom, 15)
                    Text("Vamos começar?")
                        .font(.title)
                        .padding(.bottom, 3)
                    Text("Coloque suas informações abaixo👇")
                        .padding(.bottom)
                }
                
                if !viewModel.errorMessage.isEmpty {
                    Text(viewModel.errorMessage)
                        .foregroundColor(.purple)
                }
                Form {
                    TextField("Nome completo", text: $viewModel.name)
                        .autocorrectionDisabled()
                    
                    TextField("Email", text: $viewModel.email)
                        .autocapitalization(.none)
                        .autocorrectionDisabled()
                    SecureField("Senha", text: $viewModel.password)
                }
                .frame(width: 390, height: 203)
                .scrollDisabled(true)
                .scrollContentBackground(.hidden)
                .shadow(radius: 5)
                
                TLButton(title: "Criar conta") {
                    viewModel.register()
                }
                .frame(width: 180, height: 80)
                
                Spacer()
            }
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
