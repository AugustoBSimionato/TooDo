//
//  ContentView.swift
//  TodoList
//
//  Created by Augusto Simionato on 19/05/23.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MainViewViewModel()
    @State private var showSplash = true
    
    var body: some View {
        ZStack {
            if showSplash {
                SplashScreenView()
                    .transition(.opacity)
            } else {
                if viewModel.isSignedIn, !viewModel.currentUserId.isEmpty {
                    accountView
                } else {
                    FirstView()
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation {
                    self.showSplash = false
                }
            }
        }
    }
    
    @ViewBuilder
    var accountView: some View {
        TabView {
            ToDoListView(userId: viewModel.currentUserId)
                .tabItem {
                    Image(systemName: "list.bullet.rectangle.portrait.fill")
                    Text("tarefas")
                }
            
            TimerView()
                .tabItem {
                    Image(systemName: "stopwatch.fill")
                    Text("cronômetro")
                }
        }
    }
}
