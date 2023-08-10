//
//  ToDoListItemsView.swift
//  TodoList
//
//  Created by Augusto Simionato on 19/05/23.
//

import SwiftUI
import FirebaseFirestoreSwift

struct ToDoListView: View {
    @StateObject var viewModel: ToDoListViewViewModel
    @StateObject var viewModelProfile = ProfileViewViewModel()
    @FirestoreQuery var items: [ToDoListItem]
    
    @State private var searchTask = ""
    @State private var isAnimating = false
    
    private let userId: String
    
    var filteredTasks: [ToDoListItem] {
        guard !searchTask.isEmpty else { return items }
        return items.filter { $0.title.localizedCaseInsensitiveContains(searchTask) }
    }
    
    init(userId: String) {
        self.userId = userId
        //      users/<id>/todos/<entries>
        self._items = FirestoreQuery(collectionPath: "users/\(userId)/todos")
        self._viewModel = StateObject(wrappedValue: ToDoListViewViewModel(userId: userId))
        self._viewModelProfile = StateObject(wrappedValue: ProfileViewViewModel())
    }
    
    var body: some View {
        NavigationSplitView {
            List {
                NavigationLink(destination: ListView(userId: userId)) {
                    HStack {
                        Image(systemName: "checklist.rtl")
                        Text("Lista de tarefas")
                    }
                }
                NavigationLink(destination: ProfileView()) {
                    HStack {
                        Image(systemName: "person.crop.circle")
                        Text("Perfil")
                    }
                }
                NavigationLink(destination: TermsView()) {
                    HStack {
                        Image(systemName: "person.badge.shield.checkmark.fill")
                        Text("Termos e Condições de Uso")
                    }
                }
                Button(role: .destructive) {
                    viewModelProfile.logout()
                } label: {
                    HStack {
                        Image(systemName: "rectangle.portrait.and.arrow.forward.fill")
                        Text("Sair")
                    }
                    
                }
            }
            .navigationTitle("Menu")
            .navigationBarTitleDisplayMode(.inline)
//            .toolbar {
//                ToolbarItem {
//                    Menu {
//                        NavigationLink(destination: ProfileView()) {
//                            HStack {
//                                Text("Perfil")
//                                Image(systemName: "person.crop.circle")
//                            }
//                        }
//                        
//                        NavigationLink(destination: TermsView()) {
//                            HStack {
//                                Text("Termos e Condições de Uso")
//                                Image(systemName: "person.badge.shield.checkmark.fill")
//                            }
//                        }
//                        
//                        Button(role: .destructive) {
//                            viewModelProfile.logout()
//                        } label: {
//                            HStack {
//                                Text("Sair")
//                                Image(systemName: "rectangle.portrait.and.arrow.forward.fill")
//                            }
//                            
//                        }
//                    } label: {
//                        Image(systemName: "ellipsis.circle.fill")
//                            .font(.system(size: 17))
//                            .foregroundColor(Color.accentColor)
//                    }
//                }
//            }
            
        } detail: {
            ListView(userId: userId)
        }
    }
}

struct ToDoListView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListView(userId: "odW3M0pBqYb2tY4tLzJlum3nzK83")
//            .previewInterfaceOrientation(.landscapeLeft)
    }
}
