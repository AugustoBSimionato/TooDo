//
//  LoginViewViewModel.swift
//  TodoList
//
//  Created by Augusto Simionato on 19/05/23.
//

import Foundation
import FirebaseAuth

class LoginViewViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    
    init() {
        
    }
    
    func login() {
        guard validate() else {
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password)
    }
    
    private func validate() -> Bool {
        DispatchQueue.main.async {
            self.errorMessage = ""
        }
        
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty, !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            DispatchQueue.main.async {
                self.errorMessage = "Email ou senha incorretos"
            }
            return false
        }
        
        guard email.contains("@") && email.contains(".") else {
            DispatchQueue.main.async {
                self.errorMessage = "Acho que faltou um @ ou um . no email"
            }
            return false
        }
        
        return true
    }
}

