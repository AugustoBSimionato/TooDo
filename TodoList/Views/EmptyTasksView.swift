//
//  EmptyTasksView.swift
//  TodoList
//
//  Created by Augusto Simionato on 16/10/23.
//

import SwiftUI

struct EmptyTasksView: View {
    @State private var isEmpty = false
    
    var body: some View {
        ContentUnavailableView {
            Image(systemName: "checkmark.seal.fill")
                .foregroundStyle(.accent)
                .symbolEffect(.bounce, value: isEmpty)
                .font(.system(size: 50))
            
            Text("empty-list")
                .font(.system(size: 20, weight: .black, design: .rounded))
                .foregroundStyle(.firstViewText)
                .padding(.bottom, 10)
        } description: {
            HStack {
                Text("description")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundStyle(.firstViewText)
                    .bold()
                
                Image(systemName: "plus.circle")
                    .foregroundStyle(Color.accentColor)
                    .bold()
                    .font(.system(size: 18))
                
                Text("description2")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundStyle(.firstViewText)
                    .bold()
            }
            .foregroundStyle(.firstViewText.opacity(0.7))
        }
        .onAppear {
            isEmpty.toggle()
        }
    }
}

#Preview("English") {
    EmptyTasksView()
}

#Preview("Portuguese-BR") {
    EmptyTasksView()
        .environment(\.locale, Locale(identifier: "pt-br"))
}
