//
//  ContentView.swift
//  toDoList
//
//  Created by Claire Ruttencutter on 5/14/23.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var context
    
    @FetchRequest(entity: ToDo.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \ToDo.timestamp, ascending: true)]) var toDoItems: FetchedResults<ToDo>
    
    @State private var showNewTask = false
    
    var body: some View {
        VStack {
            HStack {
                Text("To Do List")
                    .font(.system(size: 40))
                    .fontWeight(.black)
                    .foregroundColor(Color("Green"))
                
                Spacer()
                    .frame(width: 90.0)
                
                Button(action: {
                    self.showNewTask = true
                }) {
                    Text("+")
                        .font(.system(size: 40)).foregroundColor(Color("Green"))
                }
                
            }.padding()
            
            Image("border")
                .resizable(resizingMode: .stretch)
                .aspectRatio(contentMode: .fit)
            
            Spacer()
            
            List {
                ForEach(toDoItems) { toDoItem in
                    if toDoItem.isImportant == true {
                        Text("⭐️ " + (toDoItem.title ?? "No title") + " ⭐️").fontWeight(.bold).foregroundColor(Color("Green"))
                    } else {
                        Text(toDoItem.title ?? "No title")
                    }
                }.onDelete(perform: deleteTask)
            }.listStyle(.plain)
        }
        
        if showNewTask {
            NewToDoView(showNewTask: $showNewTask, title: "", isImportant: false)
                .transition(AnyTransition.opacity.animation(.easeInOut(duration: 1.0)))
        }
    }
    
    private func deleteTask(offsets: IndexSet) {
        withAnimation {
            offsets.map {toDoItems[$0]}.forEach(context.delete)
            
            do {
                try context.save()
            } catch {
                print(error)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
