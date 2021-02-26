//
//  OrderView.swift
//  Mission MFG Hub
//
//  Created by Jacob Sax on 2/12/21.
//

import SwiftUI

struct OrderListView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var orders: [Order] = [testOrder, testOrder2, testOrder3]
    @State var isShowingItemView: Bool = false
    @State var item: Item?
    var body: some View {
        ZStack {
            white
            if !isShowingItemView {
                ScrollView {
                    ForEach(0 ..< orders.count, id: \.self) { index in
                        OrderView(order: orders[index], presentItemView: presentItemView(_:))
                    }.padding()
                    Spacer()
                }.onAppear { loadOrders() }
            }
            if isShowingItemView {
                if let safeItem = item {
                    ItemView(item: safeItem)
                }
                else {
                    Text("Cannot load Item :( ")
                        .onTapGesture(perform: {
                            isShowingItemView.toggle()
                        })
                }
            }
        }
    }
}

extension OrderListView {
    func loadOrders() {
        print("load orders here")
    }
    func presentItemView(_ incomingItem: Item) -> Void {
        item = incomingItem
        withAnimation {
        isShowingItemView.toggle()
        }
    }
}

struct OrderListView_Previews: PreviewProvider {
    static var previews: some View {
        OrderListView()
    }
}
