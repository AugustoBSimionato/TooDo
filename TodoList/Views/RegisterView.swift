//
//  RegisterView.swift
//  TodoList
//
//  Created by Augusto Simionato on 19/05/23.
//

import SwiftUI

struct RegisterView: View {
    @State private var isAnimating = false
    @StateObject var viewModel = RegisterViewViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.accentColor.opacity(0.1).ignoresSafeArea()
                
                VStack {
                    ZStack {
                        Rectangle()
                            .foregroundColor(.clear)
                            .background(Color("BackgroundCard"))
                            .frame(width: 365, height: 550)
                            .cornerRadius(25)
                        
                        VStack {
                            Text("Que bom te ver aqui 🤩")
                                .font(.title)
                                .bold()
                                .foregroundColor(.accentColor)
                                .padding(.bottom, 1)
                            
                            Text("Crie sua conta para continuar!")
                                .padding(.bottom, 50)
                            
                            ZStack {
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .background(Color("BackgroundFields"))
                                    .frame(width: 290, height: 50)
                                    .cornerRadius(12)
                                    .shadow(color: .black.opacity(0.2), radius: 4)
                                
                                HStack {
                                    Image(systemName: "person.fill")
                                        .foregroundColor(.accentColor)
                                    TextField("Nome", text: $viewModel.name)
                                        .textContentType(.username)
                                        .accessibility(identifier: "campo nome")
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
                                    Image(systemName: "envelope.fill")
                                        .foregroundColor(.accentColor)
                                    TextField("Email", text: $viewModel.email)
                                        .textInputAutocapitalization(.never)
                                        .textContentType(.emailAddress)
                                        .accessibility(identifier: "campo email")
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
                                        .foregroundColor(.accentColor)
                                    SecureField("Senha", text: $viewModel.password)
                                        .textContentType(.newPassword)
                                        .accessibility(identifier: "campo senha")
                                }
                                .frame(width: 290, height: 50)
                                .padding(.leading, 25)
                            }
                            .padding(.bottom, 30)
                            
                            if !viewModel.errorMessage.isEmpty {
                                Text(viewModel.errorMessage)
                                    .foregroundColor(Color.accentColor)
                                    .bold()
                            }
                            
                            NavigationLink {
                                TermsView()
                            } label: {
                                Text("Termos e Condições de Uso")
                                    .padding(.top)
                                    .font(.callout)
                                    .bold()
                            }

                            ZStack {
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .background(Color.accentColor)
                                    .frame(width: 250, height: 50)
                                    .cornerRadius(16)
                                
                                Button {
                                    viewModel.register()
                                } label: {
                                    Text("Criar conta")
                                        .foregroundColor(.white)
                                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                                }
                            }
                            .shadow(color: .accentColor.opacity(0.8), radius: 5)
                            .padding(.top, 30)
                        }
                    }
                    .padding(.bottom, 30)
                }
                .opacity(isAnimating ? 1 : 0)
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
                                .foregroundColor(Color.accentColor)
                                .bold()
                        }
                        .opacity(isAnimating ? 1 : 0)
                    }

                }
            }
            .onAppear {
                withAnimation(.easeInOut(duration: 1.0)) {
                    isAnimating = true
                }
            }
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
