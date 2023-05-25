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
                    TLButton(title: "Sign out", background: .red) {
                        viewModel.logout()
                    }
                    .frame(width: 150, height: 80)
                    .padding()
                } else {
                    ProgressView()
                    Text("Loading Profile...")
                        .padding()
                }
            }
            .navigationTitle("Profile")
        }
        .onAppear {
            viewModel.fetchUser()
        }
    }
}

@ViewBuilder
func profile(user: User) -> some View {
    //              Avatar
    Image(systemName: "person.circle")
        .resizable()
        .aspectRatio(contentMode: .fit)
        .foregroundColor(.accentColor)
        .frame(width: 125, height: 125)
        .padding()
    
    //              Info:
    VStack(alignment: .leading) {
        HStack {
            Image(systemName: "person")
                .resizable()
                .frame(width: 20, height: 20)
            Text(user.name)
                .bold()
        }
        .padding()
        HStack {
            Image(systemName: "envelope")
                .resizable()
                .frame(width: 25, height: 20)
            Text(user.email)
                .bold()
        }
        .padding()
        HStack {
            Image(systemName: "person.badge.clock")
                .resizable()
                .frame(width: 25, height: 25)
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
