//
//  UserStorage.swift
//  ceiba-users
//
//  Created by Daniel Orellana on 1/05/22.
//

import Foundation
import CoreData
import SwiftUI

class UserStorage: ObservableObject, UserStorageProtocol {
    
    private var context: NSManagedObjectContext
    
    @Published var users: [User] = []
    @Published var fetchRemoteData: Bool = false
    
    init() {
        self.context = PersistenceController.shared.container.viewContext
    }
    
    func save(_ data: [UserModel]?) {
        guard let users = data else {
            print("Error")
            return
        }
        
        for user in users {
            let userStorage = User(context: context)
            userStorage.id = UUID()
            userStorage.userId = user.id
            userStorage.name = user.name
            userStorage.email = user.email
            userStorage.phone = user.phone
            
            do {
                try context.save()
                
                if user == users.last { get() }
            } catch let error as NSError {
                print("DBError: \(error.localizedDescription)")
            }
        }
    }
    
    func get() {
        let request: NSFetchRequest<User> = User.fetchRequest()
        
        do {
            let data = try context.fetch(request)
            
            if data.count > 0 { users = data }
            else { fetchRemoteData = true }
        } catch let error as NSError {
            print("DBError: \(error.localizedDescription)")
        }
    }
}
