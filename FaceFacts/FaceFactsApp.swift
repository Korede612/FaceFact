//
//  FaceFactsApp.swift
//  FaceFacts
//
//  Created by Oko-osi Korede on 24/01/2024.
//

import SwiftUI

@main
struct FaceFactsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Person.self)
    }
}
