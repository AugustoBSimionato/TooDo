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
        VStack {
            Image("profile-pic")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 110, height: 110)
            
            Text(user.name)
                .font(.system(size: 25, weight: .semibold, design: .rounded))
                .padding(.top, 10)
                .padding(.bottom, 30)
            
            ZStack {
                Rectangle()
                    .foregroundColor(.clear)
                    .background(Color("BackgroundFields"))
                    .frame(width: 290, height: 50)
                    .cornerRadius(12)
                    .shadow(color: .black.opacity(0.2), radius: 4)
                
                HStack {
                    Image(systemName: "envelope.fill")
                        .foregroundColor(.accentColor)
                    Text(user.email)
                        .font(.system(size: 18, weight: .regular, design: .rounded))
                }
                .frame(width: 290, height: 50)
            }
            .padding(.bottom, 15)
            
            ZStack {
                Rectangle()
                    .foregroundColor(.clear)
                    .background(Color("BackgroundFields"))
                    .frame(width: 290, height: 50)
                    .cornerRadius(12)
                    .shadow(color: .black.opacity(0.2), radius: 4)
                
                HStack {
                    Image(systemName: "person.badge.clock.fill")
                        .foregroundColor(.accentColor)
                    Text("\(Date(timeIntervalSince1970: user.joined).formatted(date: .abbreviated, time: .shortened))")
                        .font(.system(size: 17, weight: .regular, design: .rounded))
                }
                .frame(width: 290, height: 50)
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
