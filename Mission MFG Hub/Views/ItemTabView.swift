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
    
    var body: some View {
        ZStack(alignment: .center) {
            RoundedRect(color: isSelected ? gray7 : gray1, strokeColor: gray5, shadowColor: shadowGray, shadowRadius: 4, shadowY: 2, topLeft: 0, topRight: 0, bottomRight: 16, bottomLeft: 4)
                .onTapGesture(perform: { withAnimation{
                    action()
                }})
                .darkenOnHover()
            HStack {
                Text("\(item.partTitle) - \(order.customerName)")
                    .BodyStyle()
                    .foregroundColor(isSelected ? gray1 : gray5)
                    .padding([.leading, .trailing], 20)
                Spacer(minLength: 0)
                IconButton(action: deleteAction, image: "xmark.circle", size: 20, defaultColor: isSelected ? gray1 : gray5, bkgdColor: .clear, shadowColor: .clear)
                    .padding(.trailing, 12)
                    .darkenOnHover() 
            }
        }.frame(idealWidth: 320, maxWidth: 400, maxHeight: 40)
        .padding(.top, -8)
    }
}

//struct ItemTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        ZStack {
//            white
//        ItemTabView(item: testOrder.items[0], order: testOrder)
//        }
//    }
//}
