//
//  LoginView.swift
//  TodoList
//
//  Created by Augusto Simionato on 19/05/23.
//

import SwiftUI
import LocalAuthentication
import UserNotifications

struct LoginView: View {
    @StateObject var viewModel = LoginViewViewModel()
    @State private var unlocked = false
    @State private var isAnimating = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Spacer()
                    Text("Bem-vindo!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color("ButtonColor"))
                        .padding(.bottom, 30)
                    
                    
                    VStack(spacing: 20) {
                        ZStack(alignment: .leading) {
                            if viewModel.email.isEmpty {
                                Text("Email")
                                    .foregroundColor(Color("PlaceholderColor").opacity(0.8))
                            }
                            TextField("", text: $viewModel.email)
                                
                        }
                        .foregroundColor(Color("ForegroundFieldColor"))
                        .autocapitalization(.none)
                        .padding()
                        .background(Color("BackgroundFieldColor"))
                        .cornerRadius(10)
                        
                        ZStack(alignment: .leading) {
                            if viewModel.password.isEmpty {
                                Text("Senha")
                                    .foregroundColor(Color("PlaceholderColor").opacity(0.8))
                            }
                            SecureField("", text: $viewModel.password)
                        }
                        .foregroundColor(Color("ForegroundFieldColor"))
                        .padding()
                        .background(Color("BackgroundFieldColor"))
                        .cornerRadius(10)
                    }
                    .padding(.horizontal, 30)
                    
                    if !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage)
                            .foregroundColor(Color("WarnColor"))
                            .bold()
                    }
                    
                    Button {
                        let context = LAContext()
                        var error: NSError?
                        
                        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Para sua segurança") { success, authenticationError in
                                
                                if success {
                                    viewModel.login()
                                }
                            }
                        }
                    } label: {
                        Text("Entrar")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color("ButtonColor"))
                            .cornerRadius(30)
                    }
                    .padding(.horizontal, 70)
                    .padding(.top, 30)
                    
                    Text("Novo por aqui?")
                        .padding(.top)
                        .foregroundColor(.gray)
                    
                    NavigationLink("Criar conta", destination: RegisterView())
                        .bold()

                    Spacer()
                    
                    NavigationLink {
                        TermsView()
                    } label: {
                        Text("Termos e condições de Uso")
                            .padding()
                    }

                }
                .padding()
            }
            .onAppear(perform: {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        print("All set!")
                    } else if let error = error {
                        print(error.localizedDescription)
                    }
                }
            })
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
