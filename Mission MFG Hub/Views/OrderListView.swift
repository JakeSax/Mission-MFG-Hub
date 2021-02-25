//
//  OrderView.swift
//  Mission MFG Hub
//
//  Created by Jacob Sax on 2/12/21.
//

import SwiftUI

struct OrderListView: View {
    @State var orders: [Order] = [testOrder, testOrder2, testOrder3]
    
    var body: some View {
        ZStack {
            white
            ForEach(0 ..< orders.count, id: \.self) { index in
                OrderView(order: orders[index])
            }.padding()
        }
        
        
    }
}

struct OrderListView_Previews: PreviewProvider {
    static var previews: some View {
        OrderListView()
    }
}
