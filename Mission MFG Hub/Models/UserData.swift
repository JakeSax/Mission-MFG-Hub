//
//  UserData.swift
//  Mission MFG Hub
//
//  Created by Jacob Sax on 3/9/21.
//

import SwiftUI

final class UserData: ObservableObject {
    @Published var openTabs: [(item: Item, order: Order)] = []
}
