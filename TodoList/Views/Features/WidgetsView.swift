//
//  WidgetsView.swift
//  TodoList
//
//  Created by Augusto Simionato on 10/11/23.
//

import SwiftUI

struct WidgetsView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color.accentColor.opacity(0.2).ignoresSafeArea()
                
                VStack {
                    Text("Widgets and Live Activity")
                        .font(.system(size: 28, weight: .semibold, design: .rounded))
                        .padding(.trailing, 15)
                        .padding(.top, 20)
                    
                    Spacer()
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 200, height: 200)
                            .foregroundStyle(Color.accentColor)
                            .shadow(radius: 10)
                        
                        VStack {
                            Image(systemName: "arrowshape.turn.up.forward.circle.fill")
                                .foregroundStyle(.white)
                                .font(.system(size: 40))
                                .padding(.bottom)
                            
                            Text("Acessar-tarefas")
                                .multilineTextAlignment(.center)
                                .foregroundStyle(.white)
                                .font(.system(size: 23, weight: .semibold, design: .rounded))
                        }
                        .overlay {
                            Image("logo-launch")
                                .resizable()
                                .frame(width: 28, height: 24)
                                .offset(x: 65.0, y: -65.0)
                        }
                    }
                    
                    Spacer()
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 15.0)
                            .frame(width: 70, height: 70)
                            .foregroundStyle(.gray)
                            .opacity(0.3)
                        
                        Image(systemName: "list.bullet.circle.fill")
                            .foregroundStyle(.white)
                            .font(.system(size: 50))
                    }
                    
                    Spacer()
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 300, height: 90)
                            .foregroundStyle(Color.accentColor)
                            .shadow(radius: 10)
                        
                        HStack {
                            Text("Time spent on task")
                                .multilineTextAlignment(.center)
                                .foregroundStyle(.white)
                                .font(.system(size: 17, weight: .semibold, design: .rounded))
                                .padding(.trailing, 25)
                            
                            Text("0:26")
                                .multilineTextAlignment(.center)
                                .foregroundStyle(.white)
                                .font(.system(size: 30, weight: .semibold, design: .rounded))
                        }
                    }
                    
                    Spacer()
                    
                    NavigationLink {
                        SecurityView()
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
    WidgetsView()
}
