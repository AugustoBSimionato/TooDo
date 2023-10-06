//
//  SupportEmail.swift
//  TodoList
//
//  Created by Augusto Simionato on 05/10/23.
//

import UIKit
import SwiftUI

struct SupportEmail {
    let toAddress: String
    
    func send(openURL: OpenURLAction) {
        let urlString = "mailto:\(toAddress)"
        
        guard let url = URL(string: urlString) else { return }
        openURL(url) { accepted in
            if !accepted {
                print("This device does not support email")
            }
        }
    }
}
