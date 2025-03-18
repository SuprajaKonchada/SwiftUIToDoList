//
//  LoginView.swift
//  SwiftUIToDoList
//
//  Created by user262000 on 2/18/25.
//

import SwiftUI

struct LoginView: View {
    
    @State private var username: String = ""
    @State private var password: String = ""
    @AppStorage("currentUser") private var currentUser: String = ""
    @State private var errorMessage: String = ""
    
    var body: some View {
        VStack {
            Text("Login")
                .font(.largeTitle)
                .bold()
            
            TextField("Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
        
                Text(errorMessage)
                    .foregroundColor(.red)
            
            Button("Login") {
                login()
            }
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(8)
            
            NavigationLink("Still don't have an Account? Register", destination: RegisterView())
                .padding()
        }
        .padding()
    }
    
    private func login() {
        guard let users = UserDefaults.standard.array(forKey: "users") as? [[String: String]] else {
            print("No users found.")
            return
        }
        
        if users.first(where: { $0["username"] == username && $0["password"] == password }) != nil {
            currentUser = username  // Set the current user
            errorMessage = ""
        } else {
            errorMessage = "Invalid credentials"
            
        }
    }
}

#Preview {
    LoginView()
}
