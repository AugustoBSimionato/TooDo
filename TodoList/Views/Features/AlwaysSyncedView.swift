//
//  OnBoardView.swift
//  TodoList
//
//  Created by Augusto Simionato on 09/11/23.
//

import SwiftUI

struct OnBoardView: View {
    @State private var isAnimatingText = false
    @State private var isAnimatingImage = false
    @State private var isAnimatingButton = false
    @State private var isRotating = 0.0
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.accentColor.opacity(0.1).ignoresSafeArea()
                
                VStack {
                    Spacer()
                    Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundStyle(Color.accentColor)
                        .padding(.bottom, 30)
                    
                    Text("descricao1")
                        .font(.system(size: 18, weight: .medium, design: .rounded))
                        .multilineTextAlignment(.center)
                        .opacity(isAnimatingText ? 1 : 0)
                    
                    Spacer()
                    
                    NavigationLink {
                        OnBoardView1()
                    } label: {
                        ZStack {
                            Rectangle()
                                .foregroundColor(.accentColor)
                                .frame(width: 280, height: 50)
                                .cornerRadius(15)
                            
                            HStack {
                                Text("continuar")
                                    .foregroundColor(.white)
                                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                            }
                        }
                        .opacity(isAnimatingButton ? 1 : 0)
                        .shadow(color: .accentColor.opacity(0.8), radius: 5)
                    }
                }
                .onAppear {
                    withAnimation(.easeInOut(duration: 2.0)) {
                        isAnimatingText = true
                    }
                    withAnimation(Animation.easeInOut(duration: 2.0)) {
                        isAnimatingButton = true
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Suas-tarefas-salvas-na-nuvem!")
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    OnBoardView()
}
