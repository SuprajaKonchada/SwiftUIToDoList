//
//  AuthViewModel.swift
//  SwiftUIToDoList
//
//  Created by user262000 on 2/18/25.
//

import Foundation

class AuthViewModel: ObservableObject {
    
    @Published var isAuthenticated = false
    @Published var currentUser: UserModel?
    
    init() {
        checkUserSession()
    }
    
    func register(username: String, password: String) -> Bool {
        let newUser = UserModel(username: username, password: password)
        if let encoded = try? JSONEncoder().encode(newUser) {
            UserDefaults.standard.set(encoded, forKey: "registeredUser")
            return true
        }
        return false
    }
    
    func login(username: String, password: String) -> Bool {
        if let savedUserData = UserDefaults.standard.data(forKey: "registeredUser"),
           let savedUser = try? JSONDecoder().decode(UserModel.self, from: savedUserData) {
            if savedUser.username == username && savedUser.password == password {
                self.isAuthenticated = true
                self.currentUser = savedUser
                UserDefaults.standard.set(true, forKey: "isAuthenticated")
                return true
            }
        }
        return false
    }
    
    func logout() {
        self.isAuthenticated = false
        self.currentUser = nil
        UserDefaults.standard.set(false, forKey: "isAuthenticated")
    }
    
    func checkUserSession() {
        let isLoggedIn = UserDefaults.standard.bool(forKey: "isAuthenticated")
        if isLoggedIn {
            if let savedUserData = UserDefaults.standard.data(forKey: "registeredUser"),
               let savedUser = try? JSONDecoder().decode(UserModel.self, from: savedUserData) {
                self.isAuthenticated = true
                self.currentUser = savedUser
            }
        }
    }
}
