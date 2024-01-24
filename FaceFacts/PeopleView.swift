//
//  PeopleView.swift
//  FaceFacts
//
//  Created by Oko-osi Korede on 24/01/2024.
//

import SwiftData
import SwiftUI

struct PeopleView: View {
    @Environment(\.modelContext) var modelContext
    @Query var people: [Person]
    var body: some View {
        VStack {
            if people.isEmpty {
                VStack {
                    Text("No person data is stored yet")
                }
                .frame(maxHeight: .infinity, alignment: .center)
                
            } else {
                List {
                    ForEach(people) { person in
                        NavigationLink(value: person) {
                            Text(person.name)
                        }
                    }
                    .onDelete(perform: deletePeople)
                }
                
                
            }
        }
    }
    
    init(searchText: String = "",
         sortOrder: [SortDescriptor<Person>] = []) {
        _people = Query(filter: #Predicate { person in
            searchText.isEmpty ?
            true :
            person.name.localizedStandardContains(searchText) ||
            person.emailAddress.localizedStandardContains(searchText) ||
            person.detail.localizedStandardContains(searchText)
        }, sort: sortOrder)
    }
    
    func deletePeople(at offSets: IndexSet) {
        for offset in offSets {
            let person = people[offset]
            modelContext.delete(person)
        }
    }
}

#Preview {
    do {
        let previewer = try Previewer()
        return PeopleView()
            .modelContainer(previewer.container)
    } catch {
        return Text("Failed to Create Preview: \(error.localizedDescription)")
    }
}
