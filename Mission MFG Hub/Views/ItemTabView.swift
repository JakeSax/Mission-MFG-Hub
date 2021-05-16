//
//  ItemTabView.swift
//  Mission MFG Hub
//
//  Created by Jacob Sax on 3/9/21.
//

import SwiftUI

struct ItemTabView: View {
    var item: Item
    var order: Order
    @State var isSelected: Bool
    var action: () -> Void
    var deleteAction: () -> Void
    var num: Int
    
    var body: some View {
        ZStack(alignment: .center) {
            RoundedRect(color: isSelected ? black : gray1, strokeColor: isSelected ? black : gray5, shadowColor: shadowGray, shadowRadius: 4, shadowY: 2, topLeft: 0, topRight: 0, bottomRight: 16, bottomLeft: 4)
                .onTapGesture(perform: { withAnimation { action() }})
                .padding(.leading, num == 0 ? -56 : 0)
            HStack {
                Text("\(item.partTitle) - \(order.customerName)")
                    .BodyStyle()
                    .foregroundColor(isSelected ? gray1 : gray5)
                    .padding([.leading, .trailing], 20)
                    .onTapGesture(perform: { withAnimation { action() }})
                Spacer(minLength: 0)
                IconButton(action: deleteAction, image: "xmark.circle", size: 20, defaultColor: isSelected ? gray1 : gray5, bkgdColor: .clear, shadowColor: .clear)
                    .padding(.trailing, 12)
            }
        }.frame(idealWidth: 320, maxWidth: 400, maxHeight: 40)
        .padding(.top, -8)
        
        .darkenOnHover()
    }
    
}

