//
//  SwiftUIToDoListApp.swift
//  SwiftUIToDoList
//
//  Created by user262000 on 2/13/25.
//

import SwiftUI

@main
struct SwiftUIToDoListApp: App {
    
    @StateObject var listViewModel: ListViewModel = ListViewModel()
    @AppStorage("currentUser") private var currentUser: String = ""

    var body: some Scene {
        WindowGroup {
            NavigationView {
                if currentUser.isEmpty {
                    LoginView()
                } else {
                    ListView()
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .environmentObject(listViewModel)
        }
    }
}
