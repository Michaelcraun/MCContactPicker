//
//  ContactList.swift
//  ContactList_Test
//
//  Created by Michael Craun on 1/24/21.
//

import SwiftUI

struct ContactList: View {
    
    let contactGroups: [ContactGroup]
    let allowsMultiSelect: Bool
    let onSelect: (Contact) -> Void
    
    var body: some View {
    
        List {
            
            ForEach(contactGroups) { group in
                
                Section(header: Text(group.id)) {
                    
                    ForEach(group.contacts) { contact in
                        
                        ContactCell(contact: contact, allowsMultiSelect: allowsMultiSelect) { contact in
                            
                            onSelect(contact)
                            
                            
                        }
                        
                    }
                    
                }
                
            }
            
        }
    
    }
    
}

struct ContactList_Previews: PreviewProvider {
    static var previews: some View {
        ContactList(contactGroups: [], allowsMultiSelect: true, onSelect: { _ in })
    }
}
