//
//  PostStorageProtocol.swift
//  ceiba-users
//
//  Created by Daniel Orellana on 1/05/22.
//

import Foundation

protocol PostStorageProtocol {
    func save(_ data: [PostModel]?)
    func getById(_ id: Int32)
}
