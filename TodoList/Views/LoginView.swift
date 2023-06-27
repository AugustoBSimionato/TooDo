//
//  LoginView.swift
//  TodoList
//
//  Created by Augusto Simionato on 19/05/23.
//

import SwiftUI
import LocalAuthentication

struct LoginView: View {
    @StateObject var viewModel = LoginViewViewModel()
    @State private var unlocked = false
    
    var body: some View {
        NavigationView {
            ZStack {
                //          MARK: Login Form
                VStack {
                    Image("TooDo")
                        .padding(.top, 90)
                    
                    Spacer()
                    
                    if !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage)
                            .foregroundColor(.purple)
                    }
                    Form {
                        TextField("Email", text: $viewModel.email)
                            .autocapitalization(.none)
                        SecureField("Senha", text: $viewModel.password)
                    }
                    .frame(width: 390, height: 155)
                    .scrollDisabled(true)
                    .scrollContentBackground(.hidden)
                    .shadow(radius: 5)
                    
                    TLButton(title: "Entrar") {
                        let context = LAContext()
                        var error: NSError?
                        
                        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Para sua segurança") { success, authenticationError in
                                
                                if success {
                                    viewModel.login()
                                }
                            }
                        }
                    }
                    .frame(width: 150, height: 80)
                    .padding(.top)
                    
                    Spacer()
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.purple)
                            .frame(width: 170, height: 45)
                        
                        NavigationLink("Criar conta", destination: RegisterView())
                            .foregroundColor(.white)
                    }
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
