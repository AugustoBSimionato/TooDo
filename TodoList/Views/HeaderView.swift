//
//  HeaderView.swift
//  TodoList
//
//  Created by Augusto Simionato on 19/05/23.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 0)
                .foregroundColor(.pink)
                .rotationEffect(Angle(degrees: 15))
            
            VStack {
                Text("TooDo List")
                    .font(.system(size: 50))
                    .foregroundColor(.white)
                    .bold()
                Text("Get things done")
                    .font(.system(size: 30))
                    .foregroundColor(.white)
            }
            .padding(.top, 30)
        }
        .frame(width: UIScreen.main.bounds.width * 3, height: 300)
        .offset(y: -100)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
