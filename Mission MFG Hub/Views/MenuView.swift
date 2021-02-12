//
//  MenuView.swift
//  Mission MFG Hub
//
//  Created by Jacob Sax on 2/11/21.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 64) {
                Group {
                    HStack(alignment: .center, spacing: 64) {
                        Text("Orders").foregroundColor(black)
                        Text("Items").foregroundColor(gray5)
                        Text("Members").foregroundColor(gray5)
                    }.MenuTextStyle()
                    Line(width: 916)
                }.offset(x: 0, y: 2)
                Image("Logo")
            }.padding(EdgeInsets(top: 20, leading: 64, bottom: 12, trailing: 64))
            Line(width: 1000).padding(0)
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
