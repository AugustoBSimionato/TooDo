//
//  ProfileView.swift
//  TodoList
//
//  Created by Augusto Simionato on 19/05/23.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewViewModel()
    @State var image: UIImage?
    @State private var isAnimating = false
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.accent.opacity(0.1).ignoresSafeArea()
                
                VStack {
                    if let user = viewModel.user {
                        profileView(user: user)
                    } else {
                        ProgressView {
                            Text("carregando-perfil...")
                        }
                    }
                }
                .opacity(isAnimating ? 1 : 0)
                .onAppear {
                    withAnimation(.easeInOut(duration: 1.0)) {
                        isAnimating = true
                    }
                }
            }
        }
        .navigationTitle("perfil")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.fetchUser()
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    HStack {
                        Image(systemName: "chevron.backward.circle.fill")
                            .font(.system(size: 20))
                            .foregroundColor(Color.accentColor)
                            .bold()
                    }
                }
            }
        }
    }
}

@ViewBuilder
func profileView(user: User) -> some View {
    VStack {
        Image("profile-pic")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 110, height: 110)
        
        Text(user.name)
            .font(.system(size: 25, weight: .black, design: .rounded))
            .foregroundStyle(.firstViewText)
            .padding(.top, 10)
            .padding(.bottom, 30)
        
        Text(user.email)
            .font(.system(size: 17, weight: .bold, design: .rounded))
            .foregroundStyle(.firstViewText)
            .multilineTextAlignment(.center)
            .padding(.bottom, 5)
        
        Text("\(Date(timeIntervalSince1970: user.joined).formatted(date: .abbreviated, time: .shortened))")
            .foregroundStyle(.firstViewText)
            .font(.system(size: 17, weight: .bold, design: .rounded))
    }
    .padding()
}
