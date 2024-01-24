//
//  EditEvent.swift
//  FaceFacts
//
//  Created by Oko-osi Korede on 24/01/2024.
//

import SwiftUI

struct EditEvent: View {
    @Bindable var event: Event
    var body: some View {
        Form {
            TextField("Name of event", text: $event.name)
            TextField("Location", text: $event.location)
        }
        .navigationTitle("Edit Event")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    do {
        let previewer = try Previewer()
        return EditEvent(event: previewer.event)
            .modelContainer(previewer.container)
    } catch {
        return Text("Failed to Create Preview: \(error.localizedDescription)")
    }
}
