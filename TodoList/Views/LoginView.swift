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
                Color.accentColor.opacity(0.1).ignoresSafeArea()
                
                VStack {
                    Spacer()
                    
                    ZStack {
                        VStack {
                            Text("Bem vindo!")
                                .font(.title)
                                .bold()
                                .foregroundColor(.accentColor)
                                .padding(.bottom, 1)
                            
                            Text("Faça login para continuar!")
                                .padding(.bottom, 50)
                            
                            ZStack {
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .background(Color("BackgroundFields"))
                                    .frame(width: 290, height: 50)
                                    .cornerRadius(12)
                                    .shadow(color: .black.opacity(0.2), radius: 4)
                                
                                HStack {
                                    Image(systemName: "envelope.fill")
                                        .foregroundColor(.accentColor)
                                    TextField("Email", text: $viewModel.email)
                                        .textInputAutocapitalization(.never)
                                }
                                .frame(width: 290, height: 50)
                                .padding(.leading, 25)
                            }
                            .padding(.bottom, 15)
                            
                            ZStack {
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .background(Color("BackgroundFields"))
                                    .frame(width: 290, height: 50)
                                    .cornerRadius(12)
                                    .shadow(color: .black.opacity(0.2), radius: 4)
                                
                                HStack {
                                    Image(systemName: "lock.fill")
                                        .foregroundColor(.accentColor)
                                    SecureField("Senha", text: $viewModel.password)
                                        .textContentType(.password)
                                }
                                .frame(width: 290, height: 50)
                                .padding(.leading, 25)
                            }
                            
                            if !viewModel.errorMessage.isEmpty {
                                Text(viewModel.errorMessage)
                                    .foregroundColor(Color.accentColor)
                                    .bold()
                                    .padding(.top)
                            }
                            
                            ZStack {
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .background(Color.accentColor)
                                    .frame(width: 240, height: 45)
                                    .cornerRadius(16)
                                
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
                                        .foregroundColor(.white)
                                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                                }
                            }
                            .shadow(color: .accentColor.opacity(0.8), radius: 5)
                            .padding(.top, 40)
                        }
                    }
                    
                    Spacer()
                    
                    VStack {
                        Text("Primeira vez aqui?")
                            .font(.system(size: 18, weight: .semibold, design: .rounded))
                            .padding(.bottom, 2)
                        NavigationLink {
                            RegisterView()
                        } label: {
                            Text("Crie uma conta")
                                .font(.system(size: 16, weight: .bold, design: .rounded))
                                .foregroundColor(Color.accentColor)
                        }
                    }
                    .padding(.bottom)
                }
                .ignoresSafeArea(.keyboard)
                .opacity(isAnimating ? 1 : 0)
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
            .onAppear {
                withAnimation(.easeInOut(duration: 1.0)) {
                    isAnimating = true
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
