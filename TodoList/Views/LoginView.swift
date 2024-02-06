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
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.accentColor.opacity(0.1).ignoresSafeArea()
                
                VStack {
                    Spacer()
                    
                    VStack {
                        Text("olá!")
                            .font(.system(size: 35, weight: .black, design: .rounded))
                            .foregroundColor(.firstViewText)
                            .padding(.bottom, 1)
                        
                        Text("faça-login-para-continuar!")
                            .foregroundColor(.firstViewText)
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                    }
                    
                    Spacer()
                        .frame(height: 60)
                    
                    ZStack {
                        Rectangle()
                            .foregroundColor(.clear)
                            .background(Color("BackgroundFields"))
                            .frame(width: 290, height: 50)
                            .cornerRadius(12)
                            .shadow(color: .black.opacity(0.2), radius: 4)
                        
                        HStack {
                            Image(systemName: "envelope.fill")
                                .foregroundColor(.firstViewText)
                            TextField("Email", text: $viewModel.email)
                                .textInputAutocapitalization(.never)
                                .keyboardType(.emailAddress)
                        }
                        .frame(width: 290, height: 50)
                        .padding(.leading, 25)
                    }
                    .padding(.bottom, 10)
                    
                    ZStack {
                        Rectangle()
                            .foregroundColor(.clear)
                            .background(Color("BackgroundFields"))
                            .frame(width: 290, height: 50)
                            .cornerRadius(12)
                            .shadow(color: .black.opacity(0.2), radius: 4)
                        
                        HStack {
                            Image(systemName: "lock.fill")
                                .foregroundColor(.firstViewText)
                            SecureField("senha", text: $viewModel.password)
                                .textContentType(.password)
                        }
                        .frame(width: 290, height: 50)
                        .padding(.leading, 25)
                    }
                    
                    if !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage)
                            .foregroundStyle(.firstViewText)
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .padding(.top)
                    }
                    
                    Spacer()
                        .frame(height: 50)
                    
                    Button {
                        let context = LAContext()
                        var error: NSError?
                        
                        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "for-secure") { success, authenticationError in
                                if success {
                                    viewModel.login()
                                }
                            }
                        }
                    } label: {
                        ZStack {
                            Capsule()
                                .frame(width: 250, height: 50)
                                .foregroundStyle(.firstViewText)
                            Text("entrar")
                                .foregroundStyle(.firstViewForegroundButton)
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                        }
                    }
                    
                    Spacer()
                }
                .ignoresSafeArea(.keyboard)
                .opacity(isAnimating ? 1 : 0)
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
            .onAppear {
                withAnimation(.easeInOut(duration: 1.0)) {
                    isAnimating = true
                }
            }
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    HStack {
                        Image(systemName: "chevron.backward.circle.fill")
                            .font(.system(size: 20))
                            .foregroundColor(Color.firstViewText)
                            .bold()
                    }
                    .opacity(isAnimating ? 1 : 0)
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
