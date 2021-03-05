//
//  ItemPreview.swift
//  Mission MFG Hub
//
//  Created by Jacob Sax on 3/3/21.
//

import SwiftUI

struct ItemPreview: View {
    var item: Item
    var body: some View {
        Group {
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(black)
                .frame(width: 320, height: 280, alignment: .center)
                .shadow(color: shadowGray, radius: 12, x: 0, y: 8)
                .overlay(
                    VStack(alignment: .leading) {
                        item.steps[0].print.0
                            .resizable()
                            .frame(width: 296)
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
                            Text(item.steps[item.currentStep].title)
                                .H6Style()
                                .foregroundColor(gray3)
                        }.padding(EdgeInsets(top: 12, leading: 16, bottom: 16, trailing: 0))
                        Spacer()
                    }
                )
        }.lightenOnHover()
    }
}


struct ItemPreview_Previews: PreviewProvider {
    static var previews: some View {
        ItemPreview(item: testItem)
    }
}
