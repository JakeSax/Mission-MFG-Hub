//
//  OrderView.swift
//  Mission MFG Hub
//
//  Created by Jacob Sax on 2/12/21.
//

import SwiftUI

struct OrderView: View {
    var order: Order = testOrder
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .foregroundColor(white)
                .strokeAndShadow(strokeColor: gray5, shadowColor: gray3, shadowY: 6)
            
            HStack {
                VStack(alignment: .leading, spacing: 12) {
                    Text(order.customerName)
                        .foregroundColor(black)
                        .H3Style()
                    Line(width: 400, color: gray3)
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
                }.padding(EdgeInsets(top: 40, leading: 32, bottom: 32, trailing: 192))
                
                Spacer()
                ZStack {
                    RoundedRectangle(cornerRadius: 12).foregroundColor(gray1)
                    HStack(spacing: 48) {
                        ForEach(0 ..< order.items.count, id: (\.self)) { num in
                            ItemPreview(item: order.items[num])
                        }
                        Spacer()
                    }.padding(EdgeInsets(top: 24, leading: 36, bottom: 24, trailing: 36))
                }
            }
            
        }.frame(width: 1832, height: 338)
    }
}


struct ItemPreview: View {
    var item: Item
    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .foregroundColor(black)
            .frame(width: 306, height: 290, alignment: .center)
            .shadow(color: shadowGray, radius: 12, x: 0, y: 8)
            .overlay(
                VStack(alignment: .leading) {
                    item.steps[0].print.0
                        .resizable()
                        .frame(width: 282)
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(12)
                        .padding(EdgeInsets(top: 12, leading: 12, bottom: 0, trailing: 12))
                    Spacer()
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("\(item.partTitle)")
                                .foregroundColor(gray1)
                                .H6Style()
                            Text("x\(item.qty)")
                                .foregroundColor(gray3)
                                .Label2Style()
                        }
                        Text(item.steps[0].title)
                            .H6Style()
                            .foregroundColor(gray3)
                    }.padding(EdgeInsets(top: 24, leading: 12, bottom: 16, trailing: 0))
                    Spacer()
                }
            )
    }
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView()
    }
}
