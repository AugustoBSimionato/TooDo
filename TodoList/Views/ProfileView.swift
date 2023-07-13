//
//  ProfileView.swift
//  TodoList
//
//  Created by Augusto Simionato on 19/05/23.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewViewModel()
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            VStack {
                if let user = viewModel.user {
                    profileView(user: user)
                } else {
                    ProgressView()
                    Text("Carregando perfil...")
                        .padding()
                }
            }
            .padding()
        }
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
                            .foregroundColor(Color("ButtonColor"))
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
            Button {
                
            } label: {
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
            }
            .padding(.bottom, 20)
            
            Text(user.name)
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 20)
                .padding(.bottom, 30)
            
            VStack {
                VStack {
                    Image(systemName: "envelope.fill")
                        .font(.system(size: 25))
                    Text("E-mail")
                        .bold()
                    Text("\(user.email)")
                }
                .padding()
                
                VStack {
                    Image(systemName: "person.badge.clock.fill")
                        .font(.system(size: 25))
                    Text("Conta criada em")
                        .bold()
                    Text("\(Date(timeIntervalSince1970: user.joined).formatted(date: .abbreviated, time: .omitted))")
                }
                .padding()
            }
            Spacer()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
