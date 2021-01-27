//
//  ContentView.swift
//  Shared
//
//  Created by Michael Craun on 1/23/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isShowingContactPicker: Bool = false
    @State private var isSelected: Bool = false
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                Button("Import Contacts", action: { isShowingContactPicker.toggle() })
                
                
            }
            .sheet(isPresented: $isShowingContactPicker, content: {
                ContactPicker()
                { contact in
                    print(contact.givenName)
                }
                onSelectContacts: { contacts in
                    print(contacts.map({ $0.givenName }))
                }
                
            })
            
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
