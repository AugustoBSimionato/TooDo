//
//  ToDoListItemView.swift
//  TodoList
//
//  Created by Augusto Simionato on 19/05/23.
//

import SwiftUI

struct ToDoListItemView: View {
    @StateObject var viewModel = ToDoListItemViewViewModel()
    
    let item: ToDoListItem
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(item.title)
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                
                HStack {
                    Image(systemName: "calendar.badge.clock.rtl")
                        .bold()
                    Text("\(Date(timeIntervalSince1970: item.dueDate).formatted(date: .abbreviated, time: .shortened))")
                }
                .foregroundColor(Color("TextItemList"))
                .font(.system(size: 14, weight: .regular, design: .rounded))
            }
            
            Spacer()
            
            Button {
                viewModel.toggleIsDone(item: item)
                let impactMed = UIImpactFeedbackGenerator(style: .soft)
                impactMed.impactOccurred()
            } label: {
                Image(systemName: item.isDone ? "checkmark.circle.fill" : "circle")
                    .font(.system(size: 18))
                    .foregroundColor(.accentColor)
                    .symbolEffect(.bounce, value: item.isDone)
            }
        }
        .padding(8)
    }
}

struct ToDoListItemView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListItemView(item: .init(id: "123", title: "Get milk", dueDate: Date().timeIntervalSince1970, createdDate: Date().timeIntervalSince1970, isDone: false))
            .previewLayout(.sizeThatFits)
    }
}
