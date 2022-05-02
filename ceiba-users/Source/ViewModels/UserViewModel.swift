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
    @Published var showError: Bool = false
    
    var filteredUsers: [User] = []
    var searchText = ""
    
    private var cancellables = [AnyCancellable]()
    let apiClient = APIClient()
    
    init() {
        userStorage.$users
            .receive(on: DispatchQueue.main)
            .sink { completion in
                print("Completed")
                
                switch completion {
                case .failure:
                    self.showError = true
                    break
                default:
                    break
                }
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
                
                switch completion {
                case .failure:
                    self.showError = true
                    break
                default:
                    break
                }
            } receiveValue: { fetchData in
                if fetchData { self.fetchData() }
            }
            .store(in: &cancellables)
        
        
        userStorage.get()
    }
    
    func tryLoadDataAgain() {
        fetchData()
    }
    
    private func fetchData() {
        apiClient.dispatch(Users())
            .sink { completion in
                print("Completion: \(completion)")
                
                switch completion {
                case .failure:
                    self.showError = true
                    break
                default:
                    break
                }
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
