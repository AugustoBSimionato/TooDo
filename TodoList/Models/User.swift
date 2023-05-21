//
//  User.swift
//  TodoList
//
//  Created by Augusto Simionato on 19/05/23.
//

import Foundation

struct User: Codable {
    let id: String
    let name: String
    let email: String
    let joined: TimeInterval
}
