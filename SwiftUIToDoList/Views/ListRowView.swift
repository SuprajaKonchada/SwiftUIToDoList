//
//  ListRowView.swift
//  SwiftUIToDoList
//
//  Created by user262000 on 2/13/25.
//

import SwiftUI

struct ListRowView: View {
    
    @State private var isEditing = false
    @State private var editedTitle: String
    let item: ItemModel
    let onEdit: (String) -> Void
    let onToggleCompletion: () -> Void
    
    init(item: ItemModel, onEdit: @escaping (String) -> Void, onToggleCompletion: @escaping () -> Void) {
        self.item = item
        self.onEdit = onEdit
        self.onToggleCompletion = onToggleCompletion
        self._editedTitle = State(initialValue: item.title)
    }
    
    var body: some View {
        HStack {
            Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                .foregroundColor(item.isCompleted ? .green : .red)
                .onTapGesture {
                    onToggleCompletion()
                }
            
            if isEditing {
                TextField("Edit item", text: $editedTitle, onCommit: {
                    onEdit(editedTitle) // Save edited title
                    isEditing = false
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
            } else {
                Text(item.title)
                    .onTapGesture {
                        isEditing = true // Enter editing mode when tapping text
                    }
            }
            
            Spacer()
        }
        .font(.title2)
        .padding(.vertical, 8)
    }
}


#Preview {
    VStack {
        ListRowView(
            item: ItemModel(title: "First item!", isCompleted: false),
            onEdit: { _ in },
            onToggleCompletion: {}
        )
        ListRowView(
            item: ItemModel(title: "Second item!", isCompleted: true),
            onEdit: { _ in },
            onToggleCompletion: {}
        )
    }
}


