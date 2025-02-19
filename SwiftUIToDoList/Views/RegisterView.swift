//
//  RegisterView.swift
//  SwiftUIToDoList
//
//  Created by user262000 on 2/18/25.
//

import SwiftUI

struct RegisterView: View {
    
    @State private var username: String = ""
    @State private var password: String = ""
    @Environment(\.presentationMode) var presentationMode  // Used to navigate back to LoginView
    
    var body: some View {
        VStack {
            Text("Register")
                .font(.largeTitle)
                .bold()
            
            TextField("Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Register") {
                register()
            }
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(8)
            
            NavigationLink("Have an Account? Login", destination: LoginView())
                .padding()
        }
        .padding()
    }
    
    private func register() {
        var users = UserDefaults.standard.array(forKey: "users") as? [[String: String]] ?? []
        
        if users.contains(where: { $0["username"] == username }) {
            print("User already exists")
            return
        }
        
        users.append(["username": username, "password": password])
        UserDefaults.standard.set(users, forKey: "users")
        
        presentationMode.wrappedValue.dismiss()  // Navigate back to LoginView
    }
}

#Preview {
    RegisterView()
}
