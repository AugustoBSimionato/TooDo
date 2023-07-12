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
                .searchable(text: $searchTask, placement: .navigationBarDrawer(displayMode: .automatic), prompt: "Buscar tarefa")
                .overlay(alignment: .bottomTrailing) {
                    Button {
                        viewModel.showingNewItemView = true
                    } label: {
                        Image(systemName: "square.and.pencil")
                            .font(.system(size: 28, weight: .medium))
                            .bold()
                            .foregroundColor(Color("ButtonColor"))
                            .frame(width: 60, height: 60)
                            .background {
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(Color("ButtonColor")).opacity(0.4)
                            }
                            .shadow(radius: 15)
                    }
                    .padding(.trailing, 45)
                    .padding(.bottom, 40)
                }
            }
            .navigationTitle("Tarefas")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Menu {
                        NavigationLink(destination: ProfileView()) {
                            HStack {
                                Text("Perfil")
                                Image(systemName: "person.crop.circle")
                            }
                        }
                        
                        NavigationLink(destination: TermsView()) {
                            HStack {
                                Text("Termos e Condições de Uso")
                                Image(systemName: "person.badge.shield.checkmark.fill")
                            }
                        }
                        
                        Button(role: .destructive) {
                            viewModelProfile.logout()
                        } label: {
                            HStack {
                                Text("Sair")
                                    .font(.headline)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color("ButtonColor"))
                                    .cornerRadius(10)
                                Image(systemName: "rectangle.portrait.and.arrow.forward.fill")
                            }
                            
                        }
                        .padding(.horizontal, 80)
                    } label: {
                        Image(systemName: "ellipsis.circle.fill")
                            .foregroundColor(Color("ButtonColor"))
                            .padding(.leading, 5)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
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
