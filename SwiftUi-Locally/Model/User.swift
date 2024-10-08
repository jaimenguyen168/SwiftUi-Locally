//
//  User.swift
//  SwiftUi-Messenger
//
//  Created by Dat Nguyen on 6/8/24.
//

import Foundation

struct User: Codable, Hashable, Identifiable {
    let id: String
    var fullname: String
    let email: String
    var profileImageUrl: String?
}

extension User {
    static let MockUser = User(id: NSUUID().uuidString, fullname: "Dua Lipa", email: "dua@gmail.com", profileImageUrl: "dua-lipa")
}
