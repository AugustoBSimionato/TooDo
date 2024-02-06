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
                    Spacer()
                    
                    Text("que-bom-te-ver-aqui")
                        .font(.system(size: 30, weight: .black, design: .rounded))
                        .foregroundColor(.firstViewText)
                        .padding(.bottom, 1)
                    
                    Text("crie-sua-conta!")
                        .foregroundColor(.firstViewText)
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                    
                    Spacer()
                    
                    ZStack {
                        Rectangle()
                            .foregroundColor(.clear)
                            .background(Color("BackgroundFields"))
                            .frame(width: 290, height: 50)
                            .cornerRadius(12)
                            .shadow(color: .black.opacity(0.2), radius: 4)
                        
                        HStack {
                            Image(systemName: "person.fill")
                                .foregroundColor(.firstViewText)
                            TextField("nome", text: $viewModel.name)
                                .textContentType(.username)
                                .accessibility(identifier: "campo nome")
                        }
                        .frame(width: 290, height: 50)
                        .padding(.leading, 25)
                    }
                    .padding(.bottom, 7)
                    
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
                                .accessibility(identifier: "campo email")
                                .keyboardType(.emailAddress)
                        }
                        .frame(width: 290, height: 50)
                        .padding(.leading, 25)
                    }
                    .padding(.bottom, 7)
                    
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
                                .accessibility(identifier: "campo senha")
                        }
                        .frame(width: 290, height: 50)
                        .padding(.leading, 25)
                    }
                    
                    
                    
                    if !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage)
                            .foregroundColor(.firstViewText)
                            .bold()
                            .padding(.top)
                    }
                    
                    Spacer()
                        .frame(height: 25)
                    
                    Link(destination: URL(string: "https://augustobsimionato.github.io/toodo-terms/")!) {
                        Text("ao-criar-uma-conta-você-concorda-com-os-**Termos-e-Condições-de-Uso**")
                            .multilineTextAlignment(.center)
                            .frame(width: 240)
                            .font(.callout)
                            .foregroundColor(.firstViewText)
                    }
                    
                    Spacer()
                        .frame(height: 50)
                    
                    Button {
                        viewModel.register()
                    } label: {
                        ZStack {
                            Capsule()
                                .frame(width: 250, height: 50)
                                .foregroundStyle(.firstViewText)
                            Text("criar-conta")
                                .foregroundStyle(.firstViewForegroundButton)
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                        }
                    }
                    
                    Spacer()
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
                                .foregroundColor(.firstViewText)
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
