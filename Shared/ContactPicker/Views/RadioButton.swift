//
//  RadioButton.swift
//  ContactList_Test
//
//  Created by Michael Craun on 1/23/21.
//

import SwiftUI

struct RadioButton: View {
    
    @Binding var isSelected: Bool
    
    var body: some View {
        
        if isSelected {
            
            ZStack {
                
                Circle()
                    .strokeBorder(lineWidth: 2)
                
                Circle()
                    .padding(5)
            }
            
        } else {
            
            Circle()
                .strokeBorder(lineWidth: 2)
            
        }
        
    }
    
}

struct RadioButton_Previews: PreviewProvider {
    static var previews: some View {
        RadioButton(isSelected: .constant(true))
            .previewLayout(.fixed(width: 378, height: 100))
    }
}
