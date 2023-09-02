//
//  RegisterViewViewModel.swift
//  TodoList
//
//  Created by Augusto Simionato on 19/05/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class RegisterViewViewModel: ObservableObject {
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    
    init() {}
    
    func register() {
        guard validate() else {
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            guard let userId = result?.user.uid else {
                return
            }
            
            self?.insertUserRecord(id: userId)
        }
    }
    
    private func insertUserRecord(id: String) {
        let newUser = User(id: id, name: name, email: email, joined: Date().timeIntervalSince1970)
        
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(id)
            .setData(newUser.asDictionary()) { [weak self] error in
                if let error = error {
                    // Handle error on the main thread
                    DispatchQueue.main.async {
                        self?.errorMessage = "Error: \(error.localizedDescription)"
                    }
                }
            }
    }
    
    private func validate() -> Bool {
        DispatchQueue.main.async {
            self.errorMessage = ""
        }
        
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty,
              !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            
            DispatchQueue.main.async {
                self.errorMessage = "Campos estão vazios"
            }
            return false
        }
        
        guard email.contains("@") && email.contains(".") else {
            DispatchQueue.main.async {
                self.errorMessage = "Acho que faltou um @ ou um . no email"
            }
            return false
        }
        
        guard password.count >= 6 else {
            DispatchQueue.main.async {
                self.errorMessage = "Senha deve ter no mínimo 6 dígitos"
            }
            return false
        }
        
        return true
    }
}

