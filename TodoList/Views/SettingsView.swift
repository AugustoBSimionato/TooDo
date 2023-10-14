//
//  SettingsView.swift
//  TodoList
//
//  Created by Augusto Simionato on 05/10/23.
//

import SwiftUI
import Network

struct SettingsView: View {
    @Environment(\.openURL) var openURL
    @StateObject var viewModelProfile = ProfileViewViewModel()
    @State private var connectionStatus: NWPath.Status = .requiresConnection
    
    private var email = SupportEmail(toAddress: "toodo4473@gmail.com")
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    NavigationLink(destination: ProfileView()) {
                        HStack {
                            ZStack {
                                RoundedRectangle(cornerRadius: 5.0)
                                    .frame(width: 25, height: 25)
                                    .foregroundStyle(Color.accentColor)
                                
                                Image(systemName: "person.crop.circle.fill")
                                    .font(.system(size: 14))
                                    .foregroundStyle(.white)
                            }
                            Text("perfil")
                                .font(.system(size: 15, weight: .medium, design: .rounded))
                        }
                    }
                    NavigationLink(destination: TermsView()) {
                        HStack {
                            ZStack {
                                RoundedRectangle(cornerRadius: 5.0)
                                    .frame(width: 25, height: 25)
                                    .foregroundStyle(Color.accentColor)
                                
                                Image(systemName: "hand.raised.fill")
                                    .font(.system(size: 14))
                                    .foregroundStyle(.white)
                            }
                            Text("Termos-e-Condições-de-Uso")
                                .font(.system(size: 15, weight: .medium, design: .rounded))
                        }
                    }
                    
                    Button {
                        viewModelProfile.logout()
                    } label: {
                        HStack {
                            ZStack {
                                RoundedRectangle(cornerRadius: 5.0)
                                    .frame(width: 25, height: 25)
                                    .foregroundStyle(.red)
                                
                                Image(systemName: "rectangle.portrait.and.arrow.forward.fill")
                                    .font(.system(size: 13))
                                    .foregroundStyle(.white)
                            }
                            Text("sair")
                                .font(.system(size: 15, weight: .medium, design: .rounded))
                                .foregroundStyle(.red)
                        }
                    }
                } header: {
                    Text("conta")
                }
                
                Section {
                    HStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 5.0)
                                .frame(width: 25, height: 25)
                                .foregroundStyle(.blue)
                            
                            Image(systemName: "star.fill")
                                .font(.system(size: 14))
                                .foregroundStyle(.white)
                        }
                        Text("Avalie-o-TooDo")
                            .font(.system(size: 15, weight: .medium, design: .rounded))
                    }
                    
                    HStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 5.0)
                                .frame(width: 25, height: 25)
                                .foregroundStyle(.blue)
                            
                            Image(systemName: "square.and.arrow.up.fill")
                                .font(.system(size: 14))
                                .foregroundStyle(.white)
                        }
                        ShareLink(item: URL(string: "https://augustobsimionato.github.io/toodo-website/")!, message: Text("Suas-tarefas-concluídas-de-forma-rápida-e-fácil!-Baixe-já!")) {
                            Text("Compartilhar-o-TooDo")
                                .foregroundStyle(.blue)
                                .font(.system(size: 15, weight: .medium, design: .rounded))
                        }
                        
                    }
                    
                    HStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 5.0)
                                .frame(width: 25, height: 25)
                                .foregroundStyle(.blue)
                            
                            Image(systemName: "message.badge.filled.fill")
                                .font(.system(size: 14))
                                .foregroundStyle(.white)
                        }
                        Button {
                            email.send(openURL: openURL)
                        } label: {
                            Text("Enviar-Feedback")
                                .foregroundStyle(.blue)
                                .font(.system(size: 15, weight: .medium, design: .rounded))
                        }
                    }
                } header: {
                    Text("Feedback-e-compartilhamento")
                } footer: {
                    Text("Teve-alguma-ideia-ou-encontrou-um-problema?-Conte-como-está-sendo-sua-experiência-com-o-TooDo-e-o-que-poderia-ser-melhorado!")
                }

                
                Section {
                    HStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 5.0)
                                .frame(width: 25, height: 25)
                                .foregroundStyle(Color.accentColor)
                            
                            Image(systemName: "hammer.fill")
                                .font(.system(size: 14))
                                .foregroundStyle(.white)
                        }
                        Text("Versão-do-App")
                            .font(.system(size: 15, weight: .medium, design: .rounded))
                        Spacer()
                        Text("1.0")
                            .font(.system(size: 15, weight: .regular, design: .rounded))
                    }
                    
                    HStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 5.0)
                                .frame(width: 25, height: 25)
                                .foregroundStyle(connectionStatus == .satisfied ? .green : .red)
                            
                            Image(systemName: connectionStatus == .satisfied ? "cloud.fill" : "exclamationmark.arrow.triangle.2.circlepath")
                                .foregroundStyle(.white)
                                .symbolEffect(.pulse, options: .repeating, value: connectionStatus)
                        }
                        Text(connectionStatus == .satisfied ? "Tudo-sincronizado-🤩" : "Sem-internet-para-sincronizar")
                            .font(.system(size: 15, weight: .medium, design: .rounded))
                    }
                    .onAppear {
                        let monitor = NWPathMonitor()
                        monitor.pathUpdateHandler = { path in
                            DispatchQueue.main.async {
                                self.connectionStatus = path.status
                            }
                        }
                        let queue = DispatchQueue(label: "Monitor")
                        monitor.start(queue: queue)
                    }
                } header: {
                    Text("Informações-adicionais")
                } footer: {
                    Text("Informações-úteis-para-diagnóstico-do-app.")
                }
            }
            .navigationTitle("configurações")
        }
    }
}

#Preview {
    SettingsView()
}
