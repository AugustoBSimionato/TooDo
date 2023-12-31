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
            AlwaysSyncedView()
        }
    }
    
    @ViewBuilder
    var accountView: some View {
        TabView {
            NavigationStack {
                ToDoListView(userId: viewModel.currentUserId)
            }
            .tabItem {
                Image(systemName: "list.bullet.rectangle.portrait.fill")
                Text("tarefas")
            }
            
            NavigationStack {
                TimerView()
            }
            .tabItem {
                Image(systemName: "stopwatch.fill")
                Text("cronômetro")
            }
            
            NavigationStack {
                SettingsView()
            }
            .tabItem {
                Image(systemName: "gearshape.fill")
                Text("configurações")
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
