//
//  ListViewModel.swift
//  SwiftUIToDoList
//
//  Created by user262000 on 2/13/25.
//

import Foundation

class ListViewModel: ObservableObject {
    
    @Published var items: [ItemModel] = [] {
        didSet {
            saveItems()
        }
    }
    
    @Published var currentUser: String? {
        didSet {
            saveCurrentUser()
            loadUserItems()
        }
    }
    
    let userKey: String = "current_user"
    let usersListKey: String = "registered_users"

    init() {
        loadCurrentUser()
        loadUserItems()
    }
    
    // Function to get the storage key for the current user's to-do list
    private func getItemsKey(for user: String?) -> String {
        guard let user = user else { return "items_list" }
        return "items_list_\(user)"
    }
    
    // Save items based on the current user
    func saveItems() {
        guard let user = currentUser else { return }
        let itemsKey = getItemsKey(for: user)
        
        if let encodedData = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
        }
    }


    func addItem(title: String) {
        let newItem = ItemModel(title: title, isCompleted: false)
        items.append(newItem)
    }
    
    func deleteItem(indexSet: IndexSet) {
        items.remove(atOffsets: indexSet)
    }
    
    func moveItem(from: IndexSet, to: Int) {
        items.move(fromOffsets: from, toOffset: to)
    }
    
    func updateItem(item: ItemModel) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index] = item.updateCompletion()
        }
    }
    
    func editItem(item: ItemModel, newTitle: String) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index] = item.updateTitle(newTitle: newTitle)
        }
    }
    
    func loadItems(for user: String) {
        self.currentUser = user
        loadUserItems()
    }

    
    // Handle user registration and login
    func registerUser(username: String) -> Bool {
        var users = getUsersList()
        
        if users.contains(username) {
            return false  // User already exists
        }
        
        users.append(username)
        saveUsersList(users)
        return true
    }
    
    func loginUser(username: String) -> Bool {
        let users = getUsersList()
        
        if users.contains(username) {
            self.currentUser = username
            return true
        }
        
        return false
    }
    
    func logoutUser() {
        self.currentUser = nil
        UserDefaults.standard.removeObject(forKey: userKey)
    }

    private func saveUsersList(_ users: [String]) {
        if let encodedData = try? JSONEncoder().encode(users) {
            UserDefaults.standard.set(encodedData, forKey: usersListKey)
        }
    }

    private func loadCurrentUser() {
        if let user = UserDefaults.standard.string(forKey: userKey) {
            self.currentUser = user
        }
    }
    
    private func saveCurrentUser() {
        if let user = currentUser {
            UserDefaults.standard.set(user, forKey: userKey)
        }
    }
    private func getUsersList() -> [String] {
        if let data = UserDefaults.standard.data(forKey: usersListKey),
           let users = try? JSONDecoder().decode([String].self, from: data) {
            print("Registered Users: \(users)")
            return users
        }
        print("No registered users found")
        return []
    }

    func loadUserItems() {
        guard let user = currentUser else { return }
        
        let itemsKey = getItemsKey(for: user)
        
        guard let data = UserDefaults.standard.data(forKey: itemsKey),
              let savedItems = try? JSONDecoder().decode([ItemModel].self, from: data)
        else {
            print("No items found for user \(user)")
            self.items = []
            return
        }
        
        self.items = savedItems
        print("To-Do List for \(user): \(savedItems)")
    }

}
