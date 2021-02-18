//
//  ContentView.swift
//  non animating example
//
//  Created by James Warren on 19/2/21.
//

import SwiftUI
import CoreData

struct TaskRowView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var task: Task
    
    var body: some View {
        HStack {
            Button {
                withAnimation {
                    task.isComplete.toggle()
                }

                do {
                    try viewContext.save()
                } catch {
                    assertionFailure("failed to save when toggling done status")
                }
            } label: {
                CheckBox(isChecked: task.isComplete)
                    .padding()
            }
            
            Text(task.name ?? "")
                .padding()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .buttonStyle(PlainButtonStyle())
    }
}

struct CheckBox: View {
    
    var isChecked: Bool
    
    var body: some View {
        Image(systemName: isChecked ? "checkmark.square" : "square")
            .renderingMode(.original)
            .resizable()
            .scaledToFit()
            .frame(width: 25, height: 25)
    }
}

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Task.createdOn, ascending: true)],
        animation: .default)
    private var tasks: FetchedResults<Task>

    var body: some View {
        
        VStack {
            List {
                ForEach(tasks) { task in
                    TaskRowView(task: task)
                }
            }
            
            Button {
                generateDummyData()
            } label: {
                Text("Generate dummy data")
            }
            .padding()
            
            Button {
                deleteAllData()
            } label: {
                Text("delete all data")
            }
            .padding()
        }
    }
    
    private func generateDummyData() {
        withAnimation {
            for i in 0...10 {
                let newTask = Task(context: viewContext)
                newTask.createdOn = Date()
                newTask.name = "Test task \(i)"
            }
            
            do {
                try viewContext.save()
            } catch {
                fatalError("Unresolved error")
            }
        }
    }
    
    private func deleteAllData() {
        for task in tasks {
            viewContext.performAndWait {
                viewContext.delete(task)
                do {
                    try viewContext.save()
                } catch {
                    assertionFailure("failed to save")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
