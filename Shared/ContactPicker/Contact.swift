//
//  Contact.swift
//  ContactList_Test
//
//  Created by Michael Craun on 1/23/21.
//

import Foundation
import Contacts

struct Contact: Identifiable {
    
    private let contact: CNContact?
    
    let id: UUID = UUID()
    
    var familyName: String {
        return contact?.familyName ?? "Contact"
    }
    var givenName: String {
        return contact?.givenName ?? "Unknown"
    }
    var imageData: Data? {
        return contact?.imageData
    }
    var thumbnailImageData: Data? {
        return contact?.thumbnailImageData
    }
    
    init() {
        self.contact = nil
    }
    
    init(contact: CNContact) {
        self.contact = contact
    }
    
}

extension Contact: Equatable {
    
    static func == (lhs: Contact, rhs: Contact) -> Bool {
        return lhs.contact == rhs.contact
    }
    
}

struct ContactGroup: Identifiable {
    
    let contacts: [Contact]
    let id: String
    
}
