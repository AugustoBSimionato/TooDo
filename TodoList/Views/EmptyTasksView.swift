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
            Text("🎉")
                .font(.system(size: 50))
            Text("empty-list")
                .font(.system(size: 18, weight: .semibold, design: .rounded))
        } description: {
            Text("description")
                .bold()
        }
        .foregroundStyle(Color.accentColor)
    }
}

#Preview {
    EmptyTasksView()
}
