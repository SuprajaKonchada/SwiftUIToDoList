//
//  ListView.swift
//  SwiftUIToDoList
//
//  Created by user262000 on 2/13/25.
//

import SwiftUI

struct ListView: View {
    
    @EnvironmentObject var listViewModel: ListViewModel
    @AppStorage("currentUser") private var currentUser: String = ""
    
    var body: some View {
        ZStack {
            if listViewModel.items.isEmpty {
                NoItemsView()
                    .transition(AnyTransition.opacity.animation(.easeIn))
            } else {
                List {
                    ForEach(listViewModel.items) { item in
                        ListRowView(
                            item: item,
                            onEdit: { newTitle in
                                if let index = listViewModel.items.firstIndex(where: { $0.id == item.id }) {
                                    listViewModel.items[index] = ItemModel(id: item.id, title: newTitle, isCompleted: item.isCompleted)
                                }
                            },
                            onToggleCompletion: {
                                if let index = listViewModel.items.firstIndex(where: { $0.id == item.id }) {
                                    listViewModel.items[index] = item.updateCompletion()
                                }
                            }
                        )
                    }
                    .onDelete(perform: listViewModel.deleteItem)
                    .onMove(perform: listViewModel.moveItem)
                }
                .listStyle(PlainListStyle())
            }
        }
        .navigationTitle("Todo List 📝")
        .toolbar {
            if !listViewModel.items.isEmpty {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack {
                    NavigationLink("Add", destination: AddView())
                    
                    Button(action: logout) {
                        Text("Logout")
                            .foregroundColor(.red)
                    }
                }
            }
        }
        .onAppear {
            listViewModel.loadItems(for: currentUser)  // Load tasks for the logged-in user
        }
    }
    
    private func logout() {
        currentUser = ""  // Clears the current user, redirecting to LoginView
    }
}

#Preview {
    NavigationView {
        ListView()
    }
    .environmentObject(ListViewModel())
}
