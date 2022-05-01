//
//  PostViewModel.swift
//  ceiba-users
//
//  Created by Daniel Orellana on 1/05/22.
//

import Foundation
import Combine
import SwiftUI

class PostViewModel: ObservableObject {
    @ObservedObject var postStorage: PostStorage = PostStorage()
    
    @Published var posts: [Post] = []
    
    private var cancellables = [AnyCancellable]()
    let apiClient = APIClient()
    private var userId: Int32?
    
    init() {
        postStorage.$posts
            .receive(on: DispatchQueue.main)
            .sink { completion in
                print("Completed")
                switch completion {
                case .failure:
                    break
                default:
                    break
                }
            } receiveValue: { posts in
                if posts.count > 0 {
                    self.posts = posts
                }
            }
            .store(in: &cancellables)
        
        postStorage.$fetchRemoteData
            .receive(on: DispatchQueue.main)
            .sink { completion in
                print("Completed")
            } receiveValue: { fetchData in
                if fetchData { self.fetchData() }
            }
            .store(in: &cancellables)
        
        postStorage.$showPostsByUser
            .receive(on: DispatchQueue.main)
            .sink { completion in
                print("Completed")
            } receiveValue: { success in
                guard let id = self.userId else {
                    return
                }
                
                if success { self.postStorage.getById(id) }
            }
            .store(in: &cancellables)
    }
    
    func getPostById(_ userId: Int32) {
        self.userId = userId
        postStorage.getById(userId)
    }
    
    private func fetchData() {
        apiClient.dispatch(Posts())
            .sink { completion in
                print("Completion: \(completion)")
            } receiveValue: { posts in
                print("Posts: \(posts)")
                self.postStorage.save(posts)
            }
            .store(in: &cancellables)
    }
    
}
