//
//  ItemHeader.swift
//  Mission MFG Hub
//
//  Created by Jacob Sax on 2/11/21.
//

import SwiftUI

struct ItemHeader: View {
    @ObservedObject var item : Item
    var body: some View {
            Group {
                Text(item.partTitle)
                    .padding()
                    .padding(.bottom, -12)
                    .H1Style()
                    .foregroundColor(black)
                    .leftAlign()
                    .transition(.moveUpWardsWhileFadingIn)
                Line(width: 660).padding()
            }.padding(.leading, 40)
    }
}
