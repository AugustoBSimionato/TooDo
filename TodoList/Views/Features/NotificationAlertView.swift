//
//  NotificationAlertView.swift
//  TodoList
//
//  Created by Augusto Simionato on 09/11/23.
//

import SwiftUI

struct NotificationAlertView: View {
    @State private var bouncing = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.gray.opacity(0.2).ignoresSafeArea()
                
                VStack {
                    Text("Notifications")
                        .font(.system(size: 30, weight: .semibold, design: .rounded))
                        .padding(.trailing, 170)
                        .padding(.top, 20)
                    
                    Text("TooDo remind you if you have completed your tasks")
                        .font(.system(size: 23, weight: .medium, design: .rounded))
                        .foregroundStyle(.gray)
                        .padding(.trailing, 45)
                        .padding(.top, 1)
                    
                    Spacer()
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 150, height: 150)
                            .foregroundStyle(Color.accentColor)
                        
                        Image(systemName: "bell.badge.fill")
                            .font(.system(size: 90))
                            .foregroundStyle(.white)
                            .symbolEffect(.pulse, options: .repeating, value: bouncing)
                    }
                    
                    Spacer()
                    
                    NavigationLink {
                        LoginView()
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
            .onAppear {
                bouncing.toggle()
            }
            .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    NotificationAlertView()
}
