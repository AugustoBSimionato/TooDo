//
//  FirstView.swift
//  TodoList
//
//  Created by Augusto Simionato on 01/02/24.
//

import SwiftUI

struct FirstView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color.accent.opacity(0.1).ignoresSafeArea()
                
                VStack {
                    Spacer()
                    
                    Text("welcome!")
                        .foregroundStyle(.firstViewText)
                        .font(.system(size: 26, weight: .black, design: .rounded))
                    Text("organize-life")
                        .foregroundStyle(.firstViewText)
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                    
                    Spacer()
                    
                    NavigationLink {
                        LoginView()
                    } label: {
                        ZStack {
                            Capsule(style: .continuous)
                                .stroke(style: StrokeStyle(lineWidth: 2))
                                .frame(height: 50)
                                .foregroundStyle(.firstViewText)
                            Text("entrar")
                                .foregroundStyle(.firstViewText)
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                        }
                    }
                    .padding(.bottom, 5)
                    
                    NavigationLink {
                        RegisterView()
                    } label: {
                        ZStack {
                            Capsule(style: .continuous)
                                .frame(height: 50)
                                .foregroundStyle(.firstViewText)
                            Text("criar-conta")
                                .foregroundStyle(.firstViewForegroundButton)
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                        }
                    }
                    
                    Spacer()
                        .frame(height: 20)
                }
                .padding()
                .overlay {
                    Image(.rabisco)
                        .resizable()
                        .frame(width: 250, height: 45)
                    Image(.attention)
                        .resizable()
                        .frame(width: 30, height: 20)
                        .offset(x: 25, y: -120)
                        .rotationEffect(.degrees(25))
                }
            }
        }
    }
}

#Preview {
    FirstView()
}
