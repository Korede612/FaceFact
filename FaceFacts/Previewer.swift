//
//  Previewer.swift
//  FaceFacts
//
//  Created by Oko-osi Korede on 24/01/2024.
//

import SwiftData

@MainActor
struct Previewer {
    let container: ModelContainer
    let person: Person
    let event: Event
    
    init() throws {
        let modelConfig = ModelConfiguration(isStoredInMemoryOnly: true)
        container = try ModelContainer(for: Person.self, configurations: modelConfig)
        event = Event(name: "DevFest", location: "Lekki")
        person = Person(name: "john", emailAddress: "johndoe@gmail.com", detail: "No detail attached", metAt: event)
        container.mainContext.insert(person)
    }
}
