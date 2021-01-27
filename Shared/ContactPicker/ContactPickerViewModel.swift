//
//  ContactPickerViewModel.swift
//  ContactList_Test
//
//  Created by Michael Craun on 1/26/21.
//

import Foundation
import SwiftUI

class ContactPickerViewModel: ObservableObject {
    
    @Published var contactList: [ContactGroup] = []
    @Published var contacts: [Contact] = []
    @Published var searchedContacts: [SearchedContact] = []
    
    init() {
        
        self.contacts = ContactService.shared.fetch()
        self.contactList = ContactService.shared.group(contacts)
        
    }
    
    func search(text: String) {
        
        if text == "" {
            searchedContacts = []
        } else {
            searchedContacts = contacts
                .filter({ $0.matchesSearchText(text).match })
                .map({ SearchedContact(contact: $0, text: $0.matchesSearchText(text).text ?? "") })
        }
        
    }
    
}
