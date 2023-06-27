//
//  ProfileView.swift
//  TodoList
//
//  Created by Augusto Simionato on 19/05/23.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewViewModel()

    var body: some View {
        NavigationView {
            VStack {
                if let user = viewModel.user {
                    profile(user: user)
                    
                    //              Sign out
                    TLButton(title: "Sair") {
                        viewModel.logout()
                    }
                    .frame(width: 140, height: 75)
                    .padding()
                } else {
                    ProgressView()
                    Text("Carregando perfil...")
                        .padding()
                }
            }
            .navigationTitle("Perfil")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            viewModel.fetchUser()
        }
    }
}

@ViewBuilder
func profile(user: User) -> some View {
    //              Avatar
    Spacer()
    
    Image(systemName: "person.crop.circle")
        .resizable()
        .aspectRatio(contentMode: .fit)
        .foregroundColor(Color.accentColor)
        .frame(width: 125, height: 125)
    
    //              Info:
    VStack(alignment: .leading) {
        HStack {
            Image(systemName: "person.fill")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(Color.accentColor)
            Text(user.name)
        }
        .padding()
        HStack {
            Image(systemName: "envelope.fill")
                .resizable()
                .frame(width: 25, height: 20)
                .foregroundColor(Color.accentColor)
            Text(user.email)
        }
        .padding()
        HStack {
            Image(systemName: "person.badge.clock.fill")
                .resizable()
                .frame(width: 25, height: 25)
                .foregroundColor(Color.accentColor)
            Text("\(Date(timeIntervalSince1970: user.joined).formatted(date: .abbreviated, time: .shortened))")
        }
        .padding()
    }
    .padding()
    
    Spacer()
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
