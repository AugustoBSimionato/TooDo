//
//  SettingsViewViewModel.swift
//  TodoList
//
//  Created by Augusto Simionato on 22/06/23.
//

import Foundation
import FirebaseFirestore

class SettingsViewViewModel: ObservableObject {
    @Published var showingSettingsView = false
    
    private let userId: String
    
    init(userId: String) {
        self.userId = userId
    }
    
}
