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
                        .contextMenu {
                            Button(role: .destructive) {
                                viewModel.delete(id: item.id)
                            } label: {
                                HStack {
                                    Text("Apagar tarefa")
                                    Image(systemName: "trash.fill")
                                }
                            }
                            .onLongPressGesture {
                                let impactMed = UIImpactFeedbackGenerator(style: .soft)
                                impactMed.impactOccurred()
                            }
                        }
                }
                .listStyle(.sidebar)
                .searchable(text: $searchTask, placement: .navigationBarDrawer(displayMode: .automatic), prompt: "Buscar tarefa")
//                .overlay(alignment: .bottomTrailing) {
//                    Button {
//                        
//                    } label: {
//                        Image(systemName: "square.and.pencil")
//                            .font(.system(size: 28, weight: .medium))
//                            .bold()
//                            .foregroundColor(Color.accentColor)
//                            .frame(width: 60, height: 60)
//                            .background {
//                                RoundedRectangle(cornerRadius: 15)
//                                    .fill(Color.accentColor).opacity(0.4)
//                            }
//                            .shadow(radius: 15)
//                            .onTapGesture {
//                                let impactMed = UIImpactFeedbackGenerator(style: .soft)
//                                impactMed.impactOccurred()
//                                viewModel.showingNewItemView = true
//                            }
//                    }
//                    .padding(.trailing, 45)
//                    .padding(.bottom, 40)
//                }
            }
            .ignoresSafeArea(.keyboard)
            .navigationTitle("Tarefas")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $viewModel.showingNewItemView) {
                NavigationStack {
                    NewItemView(newItemPresented: $viewModel.showingNewItemView)
                        .toolbar {
                            ToolbarItem(placement: .principal) {
                                Text("Nova tarefa")
                                    .font(.system(size: 22, weight: .semibold, design: .rounded))
                            }
                        }
                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
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
                                Image(systemName: "rectangle.portrait.and.arrow.forward.fill")
                            }
                            
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle.fill")
                    }
                }
                
                ToolbarItem {
                    Button {
                        
                    } label: {
                        Image(systemName: "square.and.pencil")
                            .bold()
                            .onTapGesture {
                                let impactMed = UIImpactFeedbackGenerator(style: .soft)
                                impactMed.impactOccurred()
                                viewModel.showingNewItemView = true
                            }
                    }
                }
            }
            //            List {
            //                NavigationLink(destination: ListView(userId: userId)) {
            //                    HStack {
            //                        Image(systemName: "checklist.rtl")
            //                        Text("Lista de tarefas")
            //                    }
            //                }
            //                NavigationLink(destination: ProfileView()) {
            //                    HStack {
            //                        Image(systemName: "person.crop.circle")
            //                        Text("Perfil")
            //                    }
            //                }
            //                NavigationLink(destination: TermsView()) {
            //                    HStack {
            //                        Image(systemName: "person.badge.shield.checkmark.fill")
            //                        Text("Termos e Condições de Uso")
            //                    }
            //                }
            //                Button(role: .destructive) {
            //                    viewModelProfile.logout()
            //                } label: {
            //                    HStack {
            //                        Image(systemName: "rectangle.portrait.and.arrow.forward.fill")
            //                        Text("Sair")
            //                    }
            //
            //                }
            //            }
            //        } detail: {
            //            ListView(userId: userId)
        }
    }
}

struct ToDoListView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListView(userId: "odW3M0pBqYb2tY4tLzJlum3nzK83")
        //            .previewInterfaceOrientation(.landscapeLeft)
    }
}
