//
//  ListView.swift
//  TodoList
//
//  Created by Augusto Simionato on 10/08/23.
//

import SwiftUI
import FirebaseFirestoreSwift

struct ListView: View {
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
        VStack {
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
            }
            .listStyle(.sidebar)
            .searchable(text: $searchTask, placement: .navigationBarDrawer(displayMode: .automatic), prompt: "buscar-tarefa")
            .overlay(alignment: .bottomTrailing) {
                Button {
                    viewModel.showingNewItemView = true
                } label: {
                    Image(systemName: "square.and.pencil")
                        .font(.system(size: 28, weight: .medium))
                        .bold()
                        .foregroundColor(Color.accentColor)
                        .frame(width: 60, height: 60)
                        .background {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.accentColor).opacity(0.4)
                        }
                        .shadow(radius: 15)
                }
                .padding(.trailing, 45)
                .padding(.bottom, 40)
            }
        }
        .navigationTitle("tarefas")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $viewModel.showingNewItemView) {
            NewItemView(newItemPresented: $viewModel.showingNewItemView)
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(userId: "odW3M0pBqYb2tY4tLzJlum3nzK83")
    }
}
