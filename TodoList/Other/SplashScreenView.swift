//
//  SplashScreenView.swift
//  TodoList
//
//  Created by Augusto Simionato on 03/02/24.
//

import SwiftUI

struct SplashScreenView: View {
    var body: some View {
        ZStack {
            Color.accent.opacity(0.1).ignoresSafeArea()
            
            VStack {
                Image(.logo)
                    .resizable()
                    .frame(width: 180, height: 150)
            }
            .overlay {
                Image(.curlyline)
                    .resizable()
                    .frame(width: 250, height: 200)
                    .offset(x: -160, y: -290)
                
                Image(.curlyline)
                    .resizable()
                    .frame(width: 250, height: 200)
                    .offset(x: 160, y: 290)
            }
        }
    }
}

#Preview {
    SplashScreenView()
}
