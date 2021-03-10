//
//  OrderView.swift
//  Mission MFG Hub
//
//  Created by Jacob Sax on 2/12/21.
//

import SwiftUI

struct OrderView: View {
    @EnvironmentObject private var userData: UserData
    var order: Order = testOrder
    @Binding var isShowingItemView: Bool 
    @Binding var isShowingParentView: Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .foregroundColor(white)
                .strokeAndShadow(cornerRadius: 16, strokeColor: gray5, strokeWidth: 1.2, shadowColor: shadowGray, shadowY: 8)
            
            HStack {
                VStack(alignment: .leading, spacing: 12) {
                    Text(order.customerName)
                        .foregroundColor(black)
                        .H3Style()
                    Line(width: 540, maxWidth: 540, color: gray3).padding(.bottom, 8)
                    Text("Date: \(order.getDateString())")
                        .foregroundColor(gray7)
                        .LabelStyle()
                    Text("Due Date: \(order.dueDateString)")
                        .foregroundColor(gray7)
                        .LabelStyle()
                    Text("PO: \(order.poNum)")
                        .foregroundColor(gray7)
                        .LabelStyle()
                    Spacer()
                    Text("ORDER #: \(order.orderNum)")
                        .foregroundColor(gray7)
                        .H6Style()
                }.padding(EdgeInsets(top: 40, leading: 32, bottom: 32, trailing: 96)) // trailing 192
                
                ZStack {
                    RoundedRect(color: gray1, strokeColor: gray5, strokeWidth: 1.2, topLeft: 20, topRight: 16, bottomRight: 16, bottomLeft: 0)
                    ScrollView(.horizontal) {
                        HStack(spacing: 48) {
                            ForEach(0 ..< order.items.count, id: (\.self)) { num in
                                ItemPreview(item: order.items[num])
                                    .onTapGesture(perform: { withAnimation {
                                        presentItemView(item: order.items[num], order: order)
                                    }})
                            }
                            Spacer()
                        }.padding(EdgeInsets(top: 24, leading: 36, bottom: 24, trailing: 36))
                    }
                }
            }
        }.frame(width: 1720, height: 338)
        .environmentObject(userData)
    }
}

extension OrderView {
    func presentItemView(item: Item, order: Order) {
//        if userData.openTabs.co
        userData.openTabs.append((item: item, order: order))
        isShowingParentView = false
        isShowingItemView = true
//        }
    }
}



//struct OrderView_Previews: PreviewProvider {
//    static var previews: some View {
//        OrderView(presentItemView: {_ in })
//    }
//}
