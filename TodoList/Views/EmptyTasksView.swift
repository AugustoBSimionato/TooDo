//
//  EmptyTasksView.swift
//  TodoList
//
//  Created by Augusto Simionato on 16/10/23.
//

import SwiftUI

struct EmptyTasksView: View {
    var body: some View {
        ContentUnavailableView {
            Image(systemName: "square.stack.3d.up.slash")
                .font(.system(size: 50))
            
            Text("empty-list")
                .font(.system(size: 20, weight: .semibold, design: .rounded))
                .padding(.bottom, 10)
        } description: {
            HStack {
                Text("description")
                    .font(.system(size: 18, weight: .regular, design: .rounded))
                    .bold()
                
                Image(systemName: "plus.circle.fill")
                    .font(.system(size: 18))
                
                Text("description2")
                    .font(.system(size: 18, weight: .regular, design: .rounded))
                    .bold()
            }
            
        }
        .foregroundStyle(.gray)
    }
}

#Preview {
    EmptyTasksView()
}
