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
                    VStack(alignment: .leading) {
                        Text("Que bom te ver aqui 🤩")
                            .font(.system(size: 27, weight: .bold, design: .rounded))
                            .foregroundColor(.accentColor)
                            .padding(.bottom, 1)
                        
                        Text("Crie sua conta!")
                            .font(.system(size: 17, weight: .semibold,design: .rounded))
                    }
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
                                .textContentType(.password)
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
                            .padding(.top)
                            .padding(.bottom)
                    }
                    
                    NavigationLink {
                        TermsView()
                    } label: {
                        Text("Ao criar uma conta você concorda com os **Termos e Condições de Uso**")
                            .multilineTextAlignment(.center)
                            .frame(width: 240)
                            .font(.callout)
                    }
                    .padding(.bottom)
                    
                    ZStack {
                        Rectangle()
                            .foregroundColor(.clear)
                            .background(Color.accentColor)
                            .frame(width: 240, height: 45)
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
                    .padding(.top, 15)
                }
                .ignoresSafeArea(.keyboard)
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
