//
//  OrderView.swift
//  Mission MFG Hub
//
//  Created by Jacob Sax on 2/12/21.
//

import SwiftUI

struct OrderListView: View {
    @State var orders: [Order] = [testOrder, testOrder2, testOrder3]
    @Binding var isShowingItemView: Bool 
    @Binding var isShowingParentView: Bool
    
    var body: some View {
        ZStack {
            white
                ScrollView {
                    ForEach(0 ..< orders.count, id: \.self) { index in
                        OrderView(order: orders[index],isShowingItemView: $isShowingItemView, isShowingParentView: $isShowingParentView)
                    }.padding()
                    Spacer()
                }.onAppear { loadOrders() }
            }
    }
}

extension OrderListView {
    func loadOrders() {
        print("load orders here")
    }

}

//struct OrderListView_Previews: PreviewProvider {
//    static var previews: some View {
//        OrderListView()
//    }
//}



