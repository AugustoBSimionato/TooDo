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
        NavigationStack {
            VStack {
                if items.isEmpty {
                    EmptyTasksView()
                } else {
                    List(filteredTasks) { item in
                        ToDoListItemView(item: item)
                            .swipeActions {
                                Button {
                                    viewModel.delete(id: item.id)
                                } label: {
                                    Image(systemName: "trash.fill")
                                }
                                .tint(.red)
                                .onTapGesture {
                                    let impactMed = UIImpactFeedbackGenerator(style: .soft)
                                    impactMed.impactOccurred()
                                }
                            }
                            .contextMenu {
                                Button(role: .destructive) {
                                    viewModel.delete(id: item.id)
                                } label: {
                                    HStack {
                                        Text("apagar-tarefa")
                                        Image(systemName: "trash.fill")
                                    }
                                }
                                .onLongPressGesture {
                                    let impactMed = UIImpactFeedbackGenerator(style: .soft)
                                    impactMed.impactOccurred()
                                }
                                
                                Button {
                                    
                                } label: {
                                    HStack {
                                        Text("editar-tarefa")
                                        Image(systemName: "square.and.pencil")
                                    }
                                }
                                .onLongPressGesture {
                                    let impactMed = UIImpactFeedbackGenerator(style: .soft)
                                    impactMed.impactOccurred()
                                }
                            }
                    }
                    .refreshable {
                        
                    }
                    .listStyle(.sidebar)
                    .searchable(text: $searchTask, placement: .navigationBarDrawer(displayMode: .automatic), prompt: "buscar-tarefas")
                    .overlay {
                        if filteredTasks.isEmpty {
                            ContentUnavailableView.search
                        }
                    }
                }
            }
            .ignoresSafeArea(.keyboard)
            .navigationTitle("tarefas")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $viewModel.showingNewItemView) {
                NavigationStack {
                    NewItemView(newItemPresented: $viewModel.showingNewItemView)
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button {
                                    viewModel.showingNewItemView = false
                                } label: {
                                    Text("voltar")
                                        .font(.system(size: 16, weight: .medium, design: .rounded))
                                }

                            }
                            
                            ToolbarItem(placement: .principal) {
                                Text("nova-tarefa")
                                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                            }
                        }
                }
            }
            .toolbar {
                ToolbarItem {
                    Button {
                        
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 20))
                            .onTapGesture {
                                let impactMed = UIImpactFeedbackGenerator(style: .soft)
                                impactMed.impactOccurred()
                                viewModel.showingNewItemView = true
                            }
                    }
                }
            }
        }
    }
}

#Preview("English") {
    ToDoListView(userId: "odW3M0pBqYb2tY4tLzJlum3nzK83")
}

#Preview("Portuguese-BR") {
    ToDoListView(userId: "odW3M0pBqYb2tY4tLzJlum3nzK83")
        .environment(\.locale, Locale(identifier: "pt-br"))
}
