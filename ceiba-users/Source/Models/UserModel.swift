//
//  UserModel.swift
//  ceiba-users
//
//  Created by Daniel Orellana on 1/05/22.
//

import Foundation

struct UserModel: Codable {
    var id: Int32
    var name: String
    var email: String
    var phone: String
}

struct Users: HTTPRequest {
     typealias ReturnType = [UserModel]
     var path: String = "/users"
}
