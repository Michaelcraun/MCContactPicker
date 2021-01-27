//
//  ContactList_TestApp.swift
//  Shared
//
//  Created by Michael Craun on 1/23/21.
//

import SwiftUI

@main
struct ContactList_TestApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
    init() {
        ContactService.shared.requestPermission()
    }
}
