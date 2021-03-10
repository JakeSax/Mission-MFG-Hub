//
//  MenuView.swift
//  Mission MFG Hub
//
//  Created by Jacob Sax on 2/11/21.
//

import SwiftUI

struct MenuView: View {
    @EnvironmentObject private var userData : UserData
    
    @State private var selectedMenuItem: Int = 0
    @State private var isShowingSelectedMenuItem: Bool = true
    let menuItems = ["Orders", "Items", "Members"]
    
    @State private var isShowingItemView: Bool = false
    
    var body: some View {
        ZStack {
            white
            
            //MARK: - Menu
            VStack {
                HStack(alignment: .center, spacing: 64) {
                    ForEach(0 ..< menuItems.count, id: \.self) { num in
                        Text(menuItems[num]).foregroundColor(ifSelected(num) ? black : gray5)
                            .onTapGesture(perform: { withAnimation {
                                self.selectedMenuItem = num
                                isShowingItemView = false
                                isShowingSelectedMenuItem = true
                            }})
                            .MenuTextStyle()
                            .offset(y: 2)
                            .lightenOnHover()
                    }
                    Line(width: 748, color: gray5).offset(y: 2)
                    Image("Logo")
                }.padding(EdgeInsets(top: 16, leading: 64, bottom: 8, trailing: 64))
                Line(width: 1000, color: black).padding(0)
                
                
                //MARK: - Selected Views
                if isShowingSelectedMenuItem {
                    switch selectedMenuItem {
                    case 0: OrderListView(isShowingItemView: $isShowingItemView, isShowingParentView: $isShowingSelectedMenuItem) 
                    case 1: ItemListView()
                    case 2: MemberListView()
                    default: ItemListView()
                    }
                }
                
                if isShowingItemView {
                    ItemTabBarView(isShowingItemView: $isShowingItemView, isShowingOrderView: $isShowingSelectedMenuItem)
                }
                Spacer()
                
            }
        }.environmentObject(userData)
    }
}

extension MenuView {
    func ifSelected(_ num: Int) -> Bool {
        return num == self.selectedMenuItem
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
