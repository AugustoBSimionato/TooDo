//
//  ContentView.swift
//  TodoList
//
//  Created by Augusto Simionato on 19/05/23.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MainViewViewModel()
    
    var body: some View {
        if viewModel.isSignedIn, !viewModel.currentUserId.isEmpty {
            accountView
        } else {
            LoginView()
        }
    }
    
    @ViewBuilder
    var accountView: some View {
        TabView {
            ToDoListView(userId: viewModel.currentUserId)
                .tabItem {
                    Label("Tarefas", systemImage: "list.bullet.rectangle.portrait.fill")
                }
            ProfileView()
                .tabItem {
                    Label("Perfil", systemImage: "person.circle")
                }
        }
    }
    
    func authenticate() {
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
