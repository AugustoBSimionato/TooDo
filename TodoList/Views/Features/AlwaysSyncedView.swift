//
//  OnBoardView.swift
//  TodoList
//
//  Created by Augusto Simionato on 09/11/23.
//

import SwiftUI

struct AlwaysSyncedView: View {
    @State private var isAnimating = false
    var body: some View {
        NavigationStack {
            ZStack {
                Color.gray.opacity(0.2).ignoresSafeArea()
                
                VStack {
                    Text("Always synced")
                        .font(.system(size: 30, weight: .semibold, design: .rounded))
                        .padding(.trailing, 140)
                        .padding(.top, 20)
                    
                    Text("Every task is synced and avaliable in all logged devices")
                        .font(.system(size: 22, weight: .medium, design: .rounded))
                        .foregroundStyle(.gray)
                        .padding(.trailing, 10)
                        .padding(.top, 1)
                    
                    Spacer()
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 150, height: 150)
                            .foregroundStyle(Color.accentColor)
                        
                        Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                            .font(.system(size: 90))
                            .foregroundStyle(.white)
                            .rotationEffect(Angle(degrees: isAnimating ? 360 : 0), anchor: .center)
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                    withAnimation(.linear(duration: 2).repeatForever(autoreverses: false)) {
                                        isAnimating = true
                                    }
                                }
                            }
                    }
                    
                    Spacer()
                    
                    NavigationLink {
                        PrivacyView()
                    } label: {
                        ZStack {
                            Rectangle()
                                .foregroundColor(.accentColor)
                                .frame(width: 330, height: 55)
                                .cornerRadius(15)
                            
                            HStack {
                                Text("continuar")
                                    .foregroundColor(.white)
                                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                            }
                        }
                    }
                }
                .padding()
            }
            .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    AlwaysSyncedView()
}
