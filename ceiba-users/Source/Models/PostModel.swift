//
//  PostModel.swift
//  ceiba-users
//
//  Created by Daniel Orellana on 1/05/22.
//

struct PostModel: Codable, Equatable {
    var id: Int32
    var userId: Int32
    var title: String
    var body: String
    
    static func == (lhs: PostModel, rhs: PostModel) -> Bool {
        return lhs.id == rhs.id
    }
}

struct Posts: HTTPRequest {
     typealias ReturnType = [PostModel]
     var path: String = "/posts"
}
