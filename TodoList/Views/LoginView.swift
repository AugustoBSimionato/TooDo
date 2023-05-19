//
//  LoginView.swift
//  TodoList
//
//  Created by Augusto Simionato on 19/05/23.
//

import SwiftUI

struct LoginView: View {
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        NavigationView {
            VStack {
    //            MARK: Header
                HeaderView()
                
    //            MARK: Login Form
                Form {
                    TextField("Email Address", text: $email)
                    SecureField("Password", text: $password)
                    
                    Button {
                        
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                            Text("Log in")
                                .foregroundColor(.white)
                                .bold()
                        }
                    }
                }
                .scrollDisabled(true)
    //            MARK: Create account
                VStack {
                    Text("New here?")
                    NavigationLink("Create Account", destination: RegisterView())
                        .foregroundColor(.pink)
                }
                
                Spacer()
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
