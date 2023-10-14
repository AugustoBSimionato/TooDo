//
//  TermsView.swift
//  TodoList
//
//  Created by Augusto Simionato on 10/07/23.
//

import SwiftUI

struct TermsView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("1. Coleta e Uso de Informações Pessoais")
                        .font(.title2)
                        .bold()
                        .padding(.bottom, 10)
                    Text("1.1 Coleta de Informações")
                        .padding(.bottom, 1)
                    Text("O aplicativo TooDo coleta apenas o seu nome e endereço de e-mail para a criação de uma conta de usuário. Essas informações são estritamente necessárias para personalizar sua experiência no aplicativo e fornecer funcionalidades relevantes.")
                        .multilineTextAlignment(.leading)
                        .padding(.bottom, 10)
                    
                    Text("1.2 Armazenamento de Informações")
                        .padding(.bottom, 1)
                    Text("As informações coletadas pelo aplicativo TooDo são armazenadas com segurança nos servidores do Firebase, fornecidos pela Google. O Firebase é utilizado como um banco de dados na nuvem para armazenar os dados da sua conta e salvar as tarefas criadas por você.")
                        .multilineTextAlignment(.leading)
                        .padding(.bottom, 10)
                    
                    VStack(alignment: .leading) {
                        Text("2. Proteção de Dados e Segurança")
                            .font(.title2)
                            .bold()
                            .padding(.bottom, 10)
                        Text("2.1 Segurança dos Dados")
                            .padding(.bottom, 1)
                        Text("Tomamos medidas adequadas para garantir a segurança das informações pessoais coletadas pelo aplicativo TooDo. Implementamos medidas técnicas e organizacionais para proteger seus dados contra acesso não autorizado, uso indevido, alteração ou divulgação não autorizada.")
                            .multilineTextAlignment(.leading)
                            .padding(.bottom, 10)
                        
                        Text("2.2 Acesso aos Dados")
                            .padding(.bottom, 1)
                        Text("Apenas os funcionários autorizados da TooDo têm acesso às informações pessoais coletadas, e eles são obrigados a manter a confidencialidade dessas informações.")
                            .multilineTextAlignment(.leading)
                            .padding(.bottom, 10)
                        
                        Text("2.3 Autenticação Biométrica")
                            .padding(.bottom, 1)
                        Text("O aplicativo TooDo utiliza a autenticação biométrica, como impressão digital ou reconhecimento facial, como método padrão de login na sua conta. Isso adiciona uma camada adicional de segurança ao acesso aos seus dados.")
                            .multilineTextAlignment(.leading)
                            .padding(.bottom, 10)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("3. Compartilhamento de Informações")
                            .font(.title2)
                            .bold()
                            .padding(.bottom, 10)
                        Text("3.1 Compartilhamento Limitado")
                            .padding(.bottom, 1)
                        Text("Nós não compartilhamos suas informações pessoais com terceiros, exceto conforme necessário para fornecer os serviços oferecidos pelo aplicativo TooDo ou quando exigido por lei.")
                            .multilineTextAlignment(.leading)
                            .padding(.bottom, 10)
                        
                        Text("4. Alterações nos Termos e Condições")
                            .font(.title2)
                            .bold()
                            .padding(.bottom, 10)
                        Text("Reservamo-nos o direito de modificar estes Termos e Condições de Uso a qualquer momento, a nosso critério. Quaisquer alterações serão publicadas no aplicativo TooDo e a data de atualização será indicada no início dos Termos revisados. O uso contínuo do aplicativo após a publicação das alterações constituirá sua aceitação dessas mudanças.")
                            .multilineTextAlignment(.leading)
                            .padding(.bottom, 10)
                        
                        Text("5. Contato")
                            .font(.title2)
                            .bold()
                            .padding(.bottom, 10)
                        Text("Se você tiver alguma dúvida, preocupação ou sugestão sobre estes Termos e Condições de Uso, entre em contato conosco pelo e-mail toodo4473@gmail.com .")
                            .multilineTextAlignment(.leading)
                            .padding(.bottom, 1)
                        
                        Text("Ao utilizar o aplicativo TooDo, você reconhece que leu, entendeu e concorda com estes Termos e Condições de Uso.")
                            .multilineTextAlignment(.leading)
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Termos-e-Condições-de-Uso")
        .navigationBarTitleDisplayMode(.inline)
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

struct TermsView_Previews: PreviewProvider {
    static var previews: some View {
        TermsView()
    }
}
