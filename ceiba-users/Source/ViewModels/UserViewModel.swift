//
//  UserViewModel.swift
//  ceiba-users
//
//  Created by Daniel Orellana on 1/05/22.
//

import Foundation
import Combine

class UserViewModel: ObservableObject {
    
    private var cancellables = [AnyCancellable]()
    let apiClient = APIClient()
    
    func fetchData() {
        apiClient.dispatch(Users())
            .sink { completion in
                print("Completion: \(completion)")
            } receiveValue: { users in
                print("Users: \(users)")
            }
            .store(in: &cancellables)
    }
    
}
