//
//  ContactPicker.swift
//  ContactList_Test
//
//  Created by Michael Craun on 1/23/21.
//

import SwiftUI
import Contacts

/// - TODO: Add option to view contact before choosing, if selecting singular contact
struct ContactPicker: View {
    
    typealias ContactSelected = (Contact) -> Void
    typealias ContactsSelected = ([Contact]) -> Void
    
    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject private var model: ContactPickerViewModel
    @State private var searchText: String = ""
    @State private var selectedContacts: [Contact] = []
    
    private let service = ContactService()
    private let onContactSelected: ContactSelected?
    private let onContactsSelected: ContactsSelected?
    private var allowsMultiSelect: Bool {
        return onContactsSelected != nil
    }
    
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
            
            if searchText.isEmpty {
                
                ContactList(contactGroups: model.contactList, allowsMultiSelect: allowsMultiSelect) {
                    contactWasSelected($0)
                }
                
            } else {
                
                SearchedContactList(contacts: model.searchedContacts, allowsMultiSelect: allowsMultiSelect) { contactWasSelected($0)
                }
                
            }
            
        }
        .onChange(of: searchText, perform: { value in
            model.search(text: value)
        })
        
    }
    
    init(model: ContactPickerViewModel = ContactPickerViewModel(), onSelectContact: ContactSelected? = nil, onSelectContacts: ContactsSelected? = nil) {
        
        self.model = model
        self.onContactSelected = onSelectContact
        self.onContactsSelected = onSelectContacts
        
    }
    
    private func contactWasSelected(_ contact: Contact) {
        
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

struct ContactPicker_Previews: PreviewProvider {
    static var previews: some View {
        ContactPicker()
    }
}
