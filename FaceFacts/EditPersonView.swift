//
//  EditPersonView.swift
//  FaceFacts
//
//  Created by Oko-osi Korede on 24/01/2024.
//

import PhotosUI
import SwiftUI
import SwiftData

struct EditPersonView: View {
    @Environment(\.modelContext) var modelContext
    @Bindable var person: Person
    @Binding var path: NavigationPath
    @State private var selectedItem: PhotosPickerItem?
    
    @Query(sort: [
        SortDescriptor(\Event.name),
        SortDescriptor(\Event.location)
    ]) var events: [Event]
    var body: some View {
        Form {
            Section {
                if let imageData = person.photo,
                    let image = UIImage(data: imageData) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                }
                PhotosPicker(selection: $selectedItem, matching: .images) {
                    Label("Select a Photo", systemImage: "person")
                }
            }
            Section {
                TextField("Name", text: $person.name)
                    .textContentType(.name)
                
                TextField("Email Address", text: $person.emailAddress)
                    .textContentType(.emailAddress)
                    .textInputAutocapitalization(.never)
            }
            
            Section("Where did you meet them?") {
                Picker("Met At", selection: $person.metAt) {
                    Text("Unknown event")
                        .tag(Optional<Event>.none)
                    if events.isNotEmpty() {
                        Divider()
                        
                        ForEach(events) { event in
                            Text(event.name)
                                .tag(Optional(event))
                        }
                    }
                }
                
                Button("Add a new events", action: addEvent)
            }
            
            Section("Notes") {
                TextField("Details about this person", text: $person.detail, axis: .vertical)
                
            }
        }
        .navigationTitle("Edit Person")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(for: Event.self) { event in
            EditEvent(event: event)
        }
        .onChange(of: selectedItem, loadPhoto)
    }
    
    func addEvent() {
        let newEvent = Event(name: "", location: "")
        modelContext.insert(newEvent)
        path.append(newEvent)
    }
    
    func loadPhoto() {
        Task { @MainActor in
            person.photo = try await selectedItem?.loadTransferable(type: Data.self)
        }
    }
}

#Preview {
    do {
        let previewer = try Previewer()
        return EditPersonView(person: previewer.person, path: .constant(NavigationPath()))
            .modelContainer(previewer.container)
    } catch {
        return Text("Failed to Create Preview: \(error.localizedDescription)")
    }
}
extension Array {
    func isNotEmpty() -> Bool {
        self.isEmpty == false
    }
}
