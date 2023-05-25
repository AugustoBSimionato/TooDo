//
//  LoginView.swift
//  TodoList
//
//  Created by Augusto Simionato on 19/05/23.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
    //          MARK: Header
                HeaderView(title: "TooDo", subtitle: "Get things done", angle: 0, background: .pink)
                
    //          MARK: Login Form
                Form {
                    if !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage)
                            .foregroundColor(.red)
                    }
                    
                    TextField("Email Address", text: $viewModel.email)
                        .autocapitalization(.none)
                    SecureField("Password", text: $viewModel.password)
                    
                    TLButton(title: "Log In", background: .blue) {
                        viewModel.login()
                    }
                }
                .offset(y: -100)
                .scrollDisabled(true)
                
    //          MARK: Create account
                VStack {
                    Text("New here?")
                    NavigationLink("Create Account", destination: RegisterView())
                        .foregroundColor(.pink)
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
