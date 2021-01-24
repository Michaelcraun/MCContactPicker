//
//  SearchedContactList.swift
//  ContactList_Test
//
//  Created by Michael Craun on 1/24/21.
//

import SwiftUI

struct SearchedContactList: View {
    
    let contacts: [SearchedContact]
    let allowsMultiSelect: Bool
    let onSelect: (Contact) -> Void
    
    var body: some View {
    
        List(contacts) { searched in
            
            ContactCell(contact: searched.contact, allowsMultiSelect: allowsMultiSelect) { contact in
                
                onSelect(contact)
                
            }
            
        }
    
    }
    
}

struct SearchedContactList_Previews: PreviewProvider {
    static var previews: some View {
        SearchedContactList(
            contacts: [SearchedContact(contact: Contact(), text: "What's up, guys!?")],
            allowsMultiSelect: true,
            onSelect: { _ in })
    }
}
