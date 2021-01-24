//
//  ContactCell.swift
//  ContactList_Test
//
//  Created by Michael Craun on 1/23/21.
//

import SwiftUI
import Contacts

struct ContactCell: View {
    
    typealias OnSelect = (Contact) -> Void
    
    @State private var isSelected: Bool = false
    
    private var image: UIImage {
        if let data = contact.imageData {
            return UIImage(data: data)!
        } else if let data = contact.thumbnailImageData {
            return UIImage(data: data)!
        } else {
            return UIImage(systemName: "person.fill")!
        }
    }
    
    let contact: Contact
    let allowsMultiSelect: Bool
    let onSelect: OnSelect
    
    var body: some View {
    
        HStack {
            
            if allowsMultiSelect {
                
                RadioButton(isSelected: $isSelected)
                    .foregroundColor(Color(.systemGray4))
                    .frame(width: 25, height: 25)
                
            }
            
            VStack {
                
                HStack {
                    
                    Text(contact.givenName)
                
                    Text(contact.familyName)
                        .bold()
                    
                }
                
            }
            
            Spacer()
            
        }
        .padding(5)
        .onTapGesture {
            isSelected.toggle()
            onSelect(contact)
        }
    
    }
    
    

}

struct ContactCell_Previews: PreviewProvider {
    static var previews: some View {
        ContactCell(contact: Contact(), allowsMultiSelect: true, onSelect: { _ in })
    }
}
