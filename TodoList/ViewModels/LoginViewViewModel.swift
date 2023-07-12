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
        
//      Try log in
        Auth.auth().signIn(withEmail: email, password: password)
    }
    
    private func validate() -> Bool {
        errorMessage = ""
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty, !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Um dos campos está vazio"
            
            return false
        }
        
        guard email.contains("@") && email.contains(".") else {
            errorMessage = "Acho que faltou um @ ou um . no email"
            
            return false
        }
        
        return true
    }
}
