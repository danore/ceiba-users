//
//  PostStorage.swift
//  ceiba-users
//
//  Created by Daniel Orellana on 1/05/22.
//

import Foundation
import CoreData
import SwiftUI

class PostStorage: ObservableObject, PostStorageProtocol {
    
    private var context: NSManagedObjectContext
    
    @Published var posts: [Post] = []
    @Published var fetchRemoteData: Bool = false
    @Published var showPostsByUser: Bool = false
    
    init() {
        self.context = PersistenceController.shared.container.viewContext
    }
    
    func save(_ data: [PostModel]?) {
        guard let posts = data else {
            print("Error")
            return
        }
        
        for post in posts {
            let postStorage = Post(context: context)
            postStorage.id = UUID()
            postStorage.userId = post.userId
            postStorage.title = post.title
            postStorage.body = post.body
            
            do {
                try context.save()
                
                if post == posts.last { showPostsByUser = true }
            } catch let error as NSError {
                print("DBError: \(error.localizedDescription)")
            }
        }
    }
    
    func getById(_ id: Int32) {
        let request: NSFetchRequest<Post> = Post.fetchRequest()
        request.predicate = NSPredicate(format: "userId = %@", "\(id)")
        
        do {
            let data = try context.fetch(request)
            
            if data.count > 0 { posts = data }
            else { fetchRemoteData = true }
        } catch let error as NSError {
            print("DBError: \(error.localizedDescription)")
        }
    }
    
}
