//
//  Mission_MFG_HubApp.swift
//  Mission MFG Hub
//
//  Created by Jacob Sax on 2/8/21.
//

import SwiftUI

@main
struct Mission_MFG_HubApp: App {
    var body: some Scene {
        WindowGroup {
            ZStack {
                white
                VStack {
                    MenuView()
                ItemView(item: testItem)
                }
            }
            
        }
    }
}
