//
//  SecurityView.swift
//  TodoList
//
//  Created by Augusto Simionato on 09/11/23.
//

import SwiftUI

struct SecurityView: View {
    @State private var changing = false
    let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.gray.opacity(0.2).ignoresSafeArea()
                
                VStack {
                    Text("Security at a glance")
                        .font(.system(size: 30, weight: .semibold, design: .rounded))
                        .padding(.trailing, 90)
                        .padding(.top, 20)
                    
                    Text("TooDo uses FaceID or TouchID to let you access your tasks")
                        .font(.system(size: 23, weight: .medium, design: .rounded))
                        .foregroundStyle(.gray)
                        .padding(.trailing, 10)
                        .padding(.top, 1)
                    
                    Spacer()
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 150, height: 150)
                            .foregroundStyle(Color.accentColor)
                        
                        Image(systemName: changing ? "touchid" : "faceid")
                            .font(.system(size: 90))
                            .foregroundStyle(.white)
                            .contentTransition(.symbolEffect(.replace.offUp))
                    }
                    
                    Spacer()
                    
                    NavigationLink {
                        NotificationAlertView()
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
            .onReceive(timer) { _ in
                changing.toggle()
            }
            .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    SecurityView()
}
