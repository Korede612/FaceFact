//
//  ContentView.swift
//  FaceFacts
//
//  Created by Oko-osi Korede on 24/01/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @State private var path = NavigationPath()
    
    @State private var sortOrder = [SortDescriptor(\Person.name)]
    @State private var searchText = ""
    var body: some View {
        NavigationStack(path: $path) {
            PeopleView(searchText: searchText, sortOrder: sortOrder)
                .navigationTitle("Face Facts")
                .navigationDestination(for: Person.self) { person in
                    EditPersonView(person: person, path: $path)
                }
                .toolbar {
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sortOrder) {
                            Text("Name (A - Z")
                                .tag([SortDescriptor(\Person.name)])
                            
                            Text("Name (Z - A")
                                .tag([SortDescriptor(\Person.name, order: .reverse)])
                        }
                    }
                    Button("Add New Person", systemImage: "plus", action: addPerson)
                }
                
                .searchable(text: $searchText)
        }
    }
    
    func addPerson() {
        let newPerson = Person(name: "", emailAddress: "", detail: "")
        modelContext.insert(newPerson)
        path.append(newPerson)
    }
}

#Preview {
    do {
        let previewer = try Previewer()
        return ContentView()
            .modelContainer(previewer.container)
    } catch {
        return Text("Failed to Create Preview: \(error.localizedDescription)")
    }
    
}
