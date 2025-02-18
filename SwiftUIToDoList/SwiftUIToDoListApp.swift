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
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ListView()
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .environmentObject(listViewModel)
        }
    }
}
