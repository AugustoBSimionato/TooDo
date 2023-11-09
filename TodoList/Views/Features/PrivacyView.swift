//
//  PrivacyView.swift
//  TodoList
//
//  Created by Augusto Simionato on 09/11/23.
//

import SwiftUI

struct PrivacyView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color.gray.opacity(0.2).ignoresSafeArea()
                
                VStack {
                    Spacer()
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 150, height: 150)
                            .foregroundStyle(Color.accentColor)
                        
                        Image(systemName: "shield.lefthalf.filled.badge.checkmark")
                            .font(.system(size: 90))
                            .foregroundStyle(.white)
                    }
                    
                    VStack {
                        Text("Private By Design")
                            .font(.system(size: 30, weight: .semibold, design: .rounded))
                            .padding(.top, 20)
                        
                        Text("TooDo doesn't collect or share any analytics with third parties.")
                            .font(.system(size: 23, weight: .medium, design: .rounded))
                            .foregroundStyle(.gray)
                            .padding(.top, 1)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.horizontal)
                    
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
    PrivacyView()
}
