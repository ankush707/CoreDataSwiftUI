//
//  UserViewModel.swift
//  coreDataDemo
//
//  Created by Ankush on 13/03/23.
//

import Foundation
import UIKit
import SwiftUI
import CoreData

class UserViewModel: ObservableObject {
    
    let container: NSPersistentContainer
    
    @Published var users: [UserEntity] = []
    
    init () {
        container = NSPersistentContainer(name: "coreDataDemo")
        
        container.loadPersistentStores { description, error in
            if let error1 = error {
                print("error in container loading: \(error1)")
            }
        }
        fetchRecords()
    }
    
    func fetchRecords() {
        
        let fetchRequest = NSFetchRequest<UserEntity>(entityName: "UserEntity")
        
        do {
            users = try container.viewContext.fetch(fetchRequest)
            
        } catch let error {
            print("error in data fetching: \(error)")
        }
        
    }
    
    func addUser( firstName: String, lastName: String) {
        
        let user = UserEntity(context: container.viewContext)
        
        user.firstName = firstName
        user.lastName = lastName
        
        self.save()
        self.fetchRecords()
        
    }
    
    func updateItem(user: UserEntity? ,itemName: String) {
        withAnimation {
            if itemName != "" {
                
                user?.firstName = itemName
                
                self.save()
                
            }
        }
    }
    
    func deleteItems(offsets: IndexSet) {
        guard let index1 = offsets.first else {
            return
        }
        let entity = users[index1]
        container.viewContext.delete(entity)
        self.save()
        self.fetchRecords()
    }
    
    func save() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("error in data adding: \(error)")
        }
    }
}
