//
//  FeaturesBoardView.swift
//  TodoList
//
//  Created by Augusto Simionato on 01/08/23.
//

import SwiftUI
import UIKit

struct FeaturesBoardView: View {
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.accentColor.opacity(0.1).ignoresSafeArea()
                
                TabView {
                    OnBoardView()
                    OnBoardView1()
                    OnBoard2View()
                }
                .tabViewStyle(.page(indexDisplayMode: .always))
            }
        }
    }
}

struct OnBoardView: View {
    @State private var isAnimatingText = false
    @State private var isAnimatingImage = false
    
    var body: some View {
        VStack {
            Spacer()
            Image("cloud")
                .resizable()
                .frame(width: 150, height: 150)
                .shadow(color: .accentColor.opacity(0.5), radius: 20, y: 5)
                .opacity(isAnimatingImage ? 1 : 0)
                .offset(y: isAnimatingImage ? -20 : 20)
            
            Text("Suas-tarefas-salvas-na-nuvem!")
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .multilineTextAlignment(.center)
                .opacity(isAnimatingText ? 1 : 0)
                .padding(.bottom)
            
            Text("descricao1")
                .font(.system(size: 18, weight: .regular, design: .rounded))
                .multilineTextAlignment(.center)
                .opacity(isAnimatingText ? 1 : 0)
            Spacer()
            VStack {
                Image(systemName: "hand.draw.fill")
                    .symbolRenderingMode(.multicolor)
                    .foregroundStyle(Color.accentColor)
                    .font(.system(size: 25))
                Text("Arraste-para-continuar")
                    .font(.system(size: 14, weight: .semibold, design: .rounded))
                    .foregroundStyle(Color.accentColor)
            }
            .opacity(isAnimatingText ? 1 : 0)
            Spacer()
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 2.0)) {
                isAnimatingText = true
            }
            withAnimation(Animation.easeInOut(duration: 3.0).delay(0.5)) {
                isAnimatingImage = true
            }
        }
        .onDisappear {
            isAnimatingText = false
            isAnimatingImage = false
        }
        .padding()
    }
}

struct OnBoardView1: View {
    @State private var isAnimatingText = false
    @State private var isAnimatingImage = false
    
    var body: some View {
        VStack {
            Image("locked")
                .resizable()
                .frame(width: 150, height: 150)
                .shadow(color: .accentColor.opacity(0.5), radius: 20, y: 5)
                .opacity(isAnimatingImage ? 1 : 0)
                .offset(y: isAnimatingImage ? -20 : 20)
            
            Text("Sua-privacidade-em-1°-lugar!")
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .multilineTextAlignment(.center)
                .opacity(isAnimatingText ? 1 : 0)
                .padding(.bottom)
            
            Text("descricao2")
                .font(.system(size: 18, weight: .regular, design: .rounded))
                .multilineTextAlignment(.center)
                .opacity(isAnimatingText ? 1 : 0)
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 2.0)) {
                isAnimatingText = true
            }
            withAnimation(Animation.easeInOut(duration: 3.0).delay(0.5)) {
                isAnimatingImage = true
            }
        }
        .onDisappear {
            isAnimatingText = false
            isAnimatingImage = false
        }
        .padding()
    }
}

struct OnBoard2View: View {
    @State private var isAnimatingText = false
    @State private var isAnimatingImage = false
    @State private var isAnimatingButton = false
    
    var body: some View {
        VStack {
            Image("stop")
                .resizable()
                .frame(width: 150, height: 150)
                .shadow(color: .accentColor.opacity(0.5), radius: 20, y: 5)
                .padding(.bottom)
                .opacity(isAnimatingImage ? 1 : 0)
                .offset(y: isAnimatingImage ? -20 : 20)
            
            Text("Mas-antes!")
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .multilineTextAlignment(.center)
                .padding(.bottom, 5)
                .opacity(isAnimatingText ? 1 : 0)
            
            Text("descricao3")
                .font(.system(size: 18, weight: .regular, design: .rounded))
                .multilineTextAlignment(.center)
                .opacity(isAnimatingText ? 1 : 0)
                .padding(.bottom, 30)
            
            NavigationLink {
                LoginView()
            } label: {
                ZStack {
                    Rectangle()
                        .foregroundColor(.accentColor)
                        .frame(width: 240, height: 45)
                        .cornerRadius(16)
                    
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
            withAnimation(Animation.easeInOut(duration: 3.0).delay(0.5)) {
                isAnimatingImage = true
            }
            withAnimation(Animation.easeInOut(duration: 3.0).delay(1.0)) {
                isAnimatingButton = true
            }
        }
        .onDisappear {
            isAnimatingText = false
            isAnimatingImage = false
            isAnimatingButton = false
        }
        .padding()
    }
}

struct FeaturesBoardView_Previews: PreviewProvider {
    static var previews: some View {
        FeaturesBoardView()
    }
}
