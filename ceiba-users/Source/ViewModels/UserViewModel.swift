//
//  UserViewModel.swift
//  ceiba-users
//
//  Created by Daniel Orellana on 1/05/22.
//

import Foundation
import Combine
import SwiftUI

class UserViewModel: ObservableObject {
    @ObservedObject var userStorage: UserStorage = UserStorage()
    
    @Published var finalUsers: [User] = []
    @Published private var users: [User] = []
    var filteredUsers: [User] = []
    var searchText = ""
    
    private var cancellables = [AnyCancellable]()
    let apiClient = APIClient()
    
    init() {
        userStorage.$users
            .receive(on: DispatchQueue.main)
            .sink { completion in
                print("Completed")
            } receiveValue: { users in
                if users.count > 0 {
                    print("Users counter: \(users.count)")
                    self.users = users
                    self.finalUsers = users
                }
            }
            .store(in: &cancellables)
        
        userStorage.$fetchRemoteData
            .receive(on: DispatchQueue.main)
            .sink { completion in
                print("Completed")
            } receiveValue: { fetchData in
                if fetchData { self.fetchData() }
            }
            .store(in: &cancellables)
        
        
        userStorage.get()
    }
    
    private func fetchData() {
        apiClient.dispatch(Users())
            .sink { completion in
                print("Completion: \(completion)")
            } receiveValue: { users in
                print("Users: \(users)")
                self.userStorage.save(users)
            }
            .store(in: &cancellables)
    }
    
    func filter(onText text: String) {
        self.searchText = text
        filterUsers()
    }
    
    private func filterUsers() {
        if searchText.isEmpty {
            finalUsers = users
        }
        else {
            finalUsers = users.filter {
                $0.name!.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
}
