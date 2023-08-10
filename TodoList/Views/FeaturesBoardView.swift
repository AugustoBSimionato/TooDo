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
                    OnBoardView(image: "cloud", title: "Suas tarefas salvas na nuvem!", description: "Em segundos suas tarefas são sincronizadas para que você consiga anotar no iPhone e marcar como concluída no iPad!")
                    OnBoardView(image: "locked", title: "Sua privacidade em 1° lugar!", description: "Você só consegue acessar suas tarefas se estiver com a biometria ativa no seu iPhone ou iPad, senão não rola!")
                    OnBoard2View(image: "stop", title: "Mas antes!", description: "Precisamos da sua permissão na próxima tela para enviar lembretes de tarefas que estão vencendo.")
                }
                .tabViewStyle(.page(indexDisplayMode: .always))
            }
        }
    }
}

struct OnBoardView: View {
    @State private var isAnimatingText = false
    @State private var isAnimatingImage = false
    
    let image: String
    let title: String
    let description: String
    
    var body: some View {
        VStack {
            Image(image)
                .resizable()
                .frame(width: 150, height: 150)
                .shadow(color: .accentColor.opacity(0.5), radius: 20, y: 5)
                .opacity(isAnimatingImage ? 1 : 0)
                .offset(y: isAnimatingImage ? -20 : 20)
            
            Text(title)
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .multilineTextAlignment(.center)
                .opacity(isAnimatingText ? 1 : 0)
                .padding(.bottom)
            
            Text(description)
                .font(.system(size: 18, weight: .regular, design: .rounded))
                .multilineTextAlignment(.center)
                .opacity(isAnimatingText ? 1 : 0)
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 2.0)) {
                isAnimatingText = true
            }
            withAnimation(Animation.interpolatingSpring(stiffness: 200, damping: 15, initialVelocity: 0).delay(0.5)) {
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
    
    let image: String
    let title: String
    let description: String
    
    var body: some View {
        VStack {
            Spacer()
            Image(image)
                .resizable()
                .frame(width: 150, height: 150)
                .shadow(color: .accentColor.opacity(0.5), radius: 20, y: 5)
                .padding(.bottom)
                .opacity(isAnimatingImage ? 1 : 0)
                .offset(y: isAnimatingImage ? -20 : 20)
            
            Text(title)
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .multilineTextAlignment(.center)
                .padding(.bottom, 5)
                .opacity(isAnimatingText ? 1 : 0)
            
            Text(description)
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
                        .frame(width: 250, height: 50)
                        .cornerRadius(16)
                    
                    HStack {
                        Text("Continuar")
                            .foregroundColor(.white)
                            .font(.system(size: 18, weight: .semibold, design: .rounded))
                    }
                }
                .opacity(isAnimatingButton ? 1 : 0)
                .shadow(color: .accentColor.opacity(0.8), radius: 5)
            }
            
            Spacer()
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 2.0)) {
                isAnimatingText = true
            }
            withAnimation(Animation.interpolatingSpring(stiffness: 200, damping: 15, initialVelocity: 0).delay(0.5)) {
                isAnimatingImage = true
            }
            withAnimation(Animation.interpolatingSpring(stiffness: 200, damping: 10, initialVelocity: 0).delay(1.5)) {
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
