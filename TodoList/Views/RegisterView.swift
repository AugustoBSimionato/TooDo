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
                        Text("que-bom-te-ver-aqui-🤩")
                            .font(.system(size: 27, weight: .bold, design: .rounded))
                            .foregroundColor(.accentColor)
                            .padding(.bottom, 1)
                        
                        Text("crie-sua-conta!")
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
                            TextField("nome", text: $viewModel.name)
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
                            SecureField("senha", text: $viewModel.password)
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
                        Text("ao-criar-uma-conta-você-concorda-com-os-**Termos-e-Condições-de-Uso**")
                            .multilineTextAlignment(.center)
                            .frame(width: 240)
                            .font(.callout)
                    }
                    .padding(.bottom)
                    
                    ZStack {
                        Rectangle()
                            .foregroundColor(.accentColor)
                            .frame(width: 250, height: 50)
                            .cornerRadius(15)
                        
                        HStack {
                            Text("criar-conta")
                                .foregroundColor(.white)
                                .font(.system(size: 16, weight: .semibold, design: .rounded))
                        }
                    }
                    .padding(.top, 15)
                    .onTapGesture {
                        viewModel.register()
                    }
                    
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
