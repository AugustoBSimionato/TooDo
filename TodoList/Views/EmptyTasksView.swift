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
                .foregroundStyle(Color.accentColor)
                .symbolEffect(.bounce, value: isEmpty)
                .font(.system(size: 50))
            
            Text("empty-list")
                .font(.system(size: 20, weight: .semibold, design: .rounded))
                .foregroundStyle(Color.accentColor)
                .padding(.bottom, 10)
        } description: {
            HStack {
                Text("description")
                    .font(.system(size: 18, weight: .regular, design: .rounded))
                    .bold()
                
                Image(systemName: "plus.circle.fill")
                    .foregroundStyle(Color.accentColor)
                    .font(.system(size: 18))
                
                Text("description2")
                    .font(.system(size: 18, weight: .regular, design: .rounded))
                    .bold()
            }
            .foregroundStyle(.gray)
        }
        .onAppear {
            isEmpty.toggle()
        }
    }
}

#Preview {
    EmptyTasksView()
}
