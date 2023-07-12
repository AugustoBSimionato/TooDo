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
        ZStack {
            VStack {
                VStack {
                    Text("Vamos começar?")
                        .font(.title)
                        .bold()
                    Text("Coloque suas informações abaixo👇")
                        .bold()
                }
                .foregroundColor(Color("ButtonColor"))
                .padding(.top, 40)
                
                Spacer()
                
                VStack(spacing: 20) {
                    ZStack(alignment: .leading) {
                        if viewModel.name.isEmpty {
                            Text("Nome")
                                .foregroundColor(Color("PlaceholderColor").opacity(0.8))
                        }
                        TextField("", text: $viewModel.name)
                            
                    }
                    .foregroundColor(Color("ForegroundFieldColor"))
                    .autocapitalization(.none)
                    .padding()
                    .background(Color("BackgroundFieldColor"))
                    .cornerRadius(10)
                    
                    ZStack(alignment: .leading) {
                        if viewModel.email.isEmpty {
                            Text("Email")
                                .foregroundColor(Color("PlaceholderColor").opacity(0.8))
                        }
                        TextField("", text: $viewModel.email)
                    }
                    .foregroundColor(Color("ForegroundFieldColor"))
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
                    viewModel.register()
                } label: {
                    Text("Criar conta")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color("ButtonColor"))
                        .cornerRadius(30)
                }
                .padding(.horizontal, 50)
                .padding(.top, 30)
                
                Spacer()
            }
            .padding()
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
                            .foregroundColor(Color("ButtonColor"))
                            .bold()
                    }
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
