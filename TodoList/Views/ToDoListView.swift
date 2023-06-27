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
    @StateObject var viewModelSettings: SettingsViewViewModel
    @FirestoreQuery var items: [ToDoListItem]
    
    private let userId: String
    
    init(userId: String) {
        self.userId = userId
//      users/<id>/todos/<entries>
        self._items = FirestoreQuery(collectionPath: "users/\(userId)/todos")
        self._viewModel = StateObject(wrappedValue: ToDoListViewViewModel(userId: userId))
        self._viewModelSettings = StateObject(wrappedValue: SettingsViewViewModel(userId: userId))
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
                                HStack {
                                    Image(systemName: "trash.fill")
                                    Text("Apagar")
                                }
                            }
                            .tint(.red)
                            .onTapGesture {
                                let impactMed = UIImpactFeedbackGenerator(style: .medium)
                                    impactMed.impactOccurred()
                            }

                        }
                }
                .listStyle(.sidebar)
                .overlay(alignment: .bottomTrailing) {
                    Button {
                        viewModel.showingNewItemView = true
                    } label: {
                        Image(systemName: "plus")
                            .font(.system(size: 25, weight: .medium))
                            .bold()
                            .foregroundColor(.white)
                            .frame(width: 55, height: 55)
                            .background {
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(Color("ButtonColor"))
                            }
                            .shadow(radius: 10)
                    }
                    .padding(.trailing, 45)
                    .padding(.bottom, 40)
                }
            }
            .navigationTitle("Tarefas")
//            .toolbar {
//                Button {
//                    viewModelSettings.showingSettingsView = true
//                } label: {
//                    Image(systemName: "sidebar.right")
//                        .font(.system(size: 18))
//                        .bold()
//                        .foregroundColor(Color("ButtonColor"))
//                }
//            }
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $viewModel.showingNewItemView) { 
                NewItemView(newItemPresented: $viewModel.showingNewItemView)
            }
            .sheet(isPresented: $viewModelSettings.showingSettingsView) {
                SettingsView(settingsPresented: $viewModelSettings.showingSettingsView)
            }
        }
    }
}

struct ToDoListView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListView(userId: "odW3M0pBqYb2tY4tLzJlum3nzK83")
    }
}
