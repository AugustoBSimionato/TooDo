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
    @FirestoreQuery var items: [ToDoListItem]
    
    private let userId: String
    
    init(userId: String) {
        self.userId = userId
//      users/<id>/todos/<entries>
        self._items = FirestoreQuery(collectionPath: "users/\(userId)/todos")
        self._viewModel = StateObject(wrappedValue: ToDoListViewViewModel(userId: userId))
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List(items) { item in
                    ToDoListItemView(item: item)
                        .swipeActions {
                            Button {
//                              Delete
                                viewModel.delete(id: item.id)
                            } label: {
                                Text("Delete")
                            }
                            .tint(.red)
                            .onTapGesture {
                                let impactMed = UIImpactFeedbackGenerator(style: .soft)
                                    impactMed.impactOccurred()
                            }

                        }
                }
                .listStyle(.sidebar)
            }
            .navigationTitle("TooDo List")
            .toolbar {
                Button {
                    viewModel.showingNewItemView = true
                } label: {
                    Image(systemName: "plus")
                }

            }
            .sheet(isPresented: $viewModel.showingNewItemView) { 
                NewItemView(newItemPresented: $viewModel.showingNewItemView)
            }
        }
    }
}

struct ToDoListView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListView(userId: "odW3M0pBqYb2tY4tLzJlum3nzK83")
    }
}
