//
//  MenuView.swift
//  Mission MFG Hub
//
//  Created by Jacob Sax on 2/11/21.
//

import SwiftUI

struct MenuView: View {
    @State private var selectedTab: Int = 0
    let menuItems = ["Orders", "Items", "Members"]
    
    var body: some View {
        ZStack {
            white
            VStack {
                HStack(alignment: .center, spacing: 64) {
                    ForEach(0 ..< menuItems.count, id: \.self) { num in
                        Text(menuItems[num]).foregroundColor(ifSelected(num) ? black : gray5)
                            .onTapGesture(perform: { self.selectedTab = num })
                            .MenuTextStyle()
                            .offset(y: 2)
                            .lightenOnHover()
                    }
                    Line(width: 748, color: gray5).offset(y: 2)
                    Image("Logo")
                }.padding(EdgeInsets(top: 20, leading: 64, bottom: 12, trailing: 64))
                Line(width: 1000, color: black).padding(0)
                switch selectedTab {
                case 0: ItemView(item: testItem) // should be OrderListView()
                case 1: ItemListView()
                case 2: OrderListView() // should be ItemView
                default: OrderListView()
                }
                Spacer()
            }
        }
    }
}

extension MenuView {
    func ifSelected(_ num: Int) -> Bool {
        return num == self.selectedTab
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
