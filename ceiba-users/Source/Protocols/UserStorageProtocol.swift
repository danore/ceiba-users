//
//  UserStorageProtocol.swift
//  ceiba-users
//
//  Created by Daniel Orellana on 1/05/22.
//

import Foundation

protocol UserStorageProtocol {
    func save(_ data: [UserModel]?)
    func get()
}
