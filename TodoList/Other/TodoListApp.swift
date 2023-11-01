//
//  TodoListApp.swift
//  TodoList
//
//  Created by Augusto Simionato on 19/05/23.
//

import SwiftUI
import FirebaseCore
import TipKit

@main
struct TodoListApp: App {
    init() {
        FirebaseApp.configure()
        try? Tips.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
