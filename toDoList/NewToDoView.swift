//
//  NewToDoView.swift
//  toDoList
//
//  Created by Claire Ruttencutter on 5/14/23.
//

import SwiftUI

struct NewToDoView: View {
    @Environment(\.managedObjectContext) var context
    //@Binding var toDoItems: [ToDoItem]
    @Binding var showNewTask : Bool
    @State var title: String
    @State var isImportant: Bool
    
    var body: some View {
        VStack {
            Text("Add a new task")
                .font(.title)
                .fontWeight(.bold).padding(.top, 40.0)
            
            TextField("Enter the task description", text: $title).padding()
                .background(Color(.white))
                .cornerRadius(15)
                .padding()
            
            Toggle(isOn: $isImportant) {
                Text("Is it important?")
            }.padding()
            
            Button(action: {
                self.addTask(title: self.title, isImportant: self.isImportant)
                self.showNewTask = false
            }) {
                Text("Add")
                    .font(.title3).foregroundColor(Color("Green"))
            }.padding(.bottom, 40.0)
                .buttonStyle(.borderedProminent)
                .tint(.white)
        }.background(Color("Green"))
    }
    
    private func addTask(title: String, isImportant: Bool = false) {
//        let task = ToDoItem(title: title, isImportant: isImportant)
//        toDoItems.append(task)
        let task = ToDo(context: context)
        task.id = UUID()
        task.title = title
        task.isImportant = isImportant
        task.timestamp = Date()
        
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
}

struct NewToDoView_Previews: PreviewProvider {
    static var previews: some View {
        NewToDoView(showNewTask: .constant(true), title: "", isImportant: false)
    }
}
