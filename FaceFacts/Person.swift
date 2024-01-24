//
//  Person.swift
//  FaceFacts
//
//  Created by Oko-osi Korede on 24/01/2024.
//

import Foundation
import SwiftData

@Model
class Person {
    var name: String
    var emailAddress: String
    var detail: String
    var metAt: Event?
    @Attribute(.externalStorage) var photo: Data?
    
    
    init(name: String, emailAddress: String, detail: String, metAt: Event? = nil) {
        self.name = name
        self.emailAddress = emailAddress
        self.detail = detail
        self.metAt = metAt
    }
}
