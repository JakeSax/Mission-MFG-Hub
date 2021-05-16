//
//  OrderInfoView.swift
//  Mission MFG Hub
//
//  Created by Jacob Sax on 5/16/21.
//

import SwiftUI

struct OrderInfoView: View {
    @State var item: Item
    @State var customer: String
    @State var dueDate: String
    
    var body: some View {
        HStack(alignment: .center) {
            VLine(height: 96, color: gray3)
            VStack(alignment: .leading, spacing: 20) {
                TextPair(text1: "PART NUMBER: ", text2: item.partNum, color1: gray6, color2: black)
                TextPair(text1: "QTY: ", text2: String(item.qty), color1: gray6, color2: black)
            }.padding(.leading, 32)
            Spacer()
            VLine(height: 96, color: gray3)
            VStack(alignment: .leading, spacing: 20) {
                TextPair(text1: "CUSTOMER: ", text2: customer, color1: gray6, color2: black)
                TextPair(text1: "DUE BY: ", text2: dueDate, color1: gray6, color2: black)
            }.padding(.leading, 32)
            Spacer()
            VLine(height: 96, color: gray3)
        }.padding(.top, 56)
        .LabelStyle()
    }
}
