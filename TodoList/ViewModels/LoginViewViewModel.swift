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
        
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                let nsError = error as NSError
                switch nsError.code {
                case AuthErrorCode.wrongPassword.rawValue:
                    DispatchQueue.main.async {
                        self.errorMessage = "Senha errada"
                    }
                default:
                    DispatchQueue.main.async {
                        self.errorMessage = "Erro no login, tente de novo"
                    }
                }
            } else {
                
            }
        }
    }
    
    private func validate() -> Bool {
        DispatchQueue.main.async {
            self.errorMessage = ""
        }
        
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty, !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            DispatchQueue.main.async {
                self.errorMessage = "Campos vazios"
            }
            return false
        }
        
        guard email.contains("@") && email.contains(".") else {
            DispatchQueue.main.async {
                self.errorMessage = "@ ou .com(.br) estão faltando no email"
            }
            return false
        }
        
        return true
    }
}

