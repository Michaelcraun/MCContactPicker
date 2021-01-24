//
//  ContactPicker.swift
//  ContactList_Test
//
//  Created by Michael Craun on 1/23/21.
//

import SwiftUI
import Contacts

struct ContactPicker: View {
    
    typealias ContactSelected = (Contact) -> Void
    typealias ContactsSelected = ([Contact]) -> Void
    
    @Environment(\.presentationMode) private var presentationMode
    @State private var searchText: String = ""
    @State private var selectedContacts: [Contact] = []
    
    private let service = ContactService()
    private let onContactSelected: ContactSelected?
    private let onContactsSelected: ContactsSelected?
    
    var body: some View {
        
        VStack {
            
            HStack {
                
                // TODO: Should be dynamic
                Button("Cancel", action: {
                    presentationMode.wrappedValue.dismiss()
                })
                
                Spacer()
                
                // TODO: Should be dynamic
                Text("Contacts")
                    .font(.title3)
                    .fontWeight(.bold)
                
                Spacer()
                
                // TODO: Should be dynamic
                Button("Done", action: {
                    onContactsSelected?(selectedContacts)
                    presentationMode.wrappedValue.dismiss()
                })
                
            }
            .padding()
            
            SearchBar(text: $searchText)
            
            List {
                
                ForEach(service.contactList) { group in
                    
                    Section(header: Text(group.id)) {
                        
                        ForEach(group.contacts) { contact in
                            
                            ContactCell(contact: contact, allowsMultiSelect: onContactsSelected != nil) { contact in
                                
                                if onContactsSelected == nil {
                                    onContactSelected?(contact)
                                    presentationMode.wrappedValue.dismiss()
                                } else {
                                    if selectedContacts.contains(contact) {
                                        selectedContacts.removeAll(where: { $0 == contact })
                                    } else {
                                        selectedContacts.append(contact)
                                    }
                                }
                                
                            }
                            
                        }
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
    init(onSelectContact: ContactSelected? = nil, onSelectContacts: ContactsSelected? = nil) {
        
        self.onContactSelected = onSelectContact
        self.onContactsSelected = onSelectContacts
        
    }
    
}

struct ContactPicker_Previews: PreviewProvider {
    static var previews: some View {
        ContactPicker()
    }
}
