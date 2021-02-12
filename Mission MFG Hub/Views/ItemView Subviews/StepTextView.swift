//
//  StepTextView.swift
//  Mission MFG Hub
//
//  Created by Jacob Sax on 2/11/21.
//

import SwiftUI

struct StepTextView: View {
    @Binding var item: Item
    @Binding var currentStep: Int
    var refreshAction: () -> Void
    var editAction: () -> Void
    var body: some View {
        Group {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Group {
                        RefreshButton(action:{ refreshAction() })
                        EditButton(action: { editAction() })
                    }.rightAlign()
                    .offset(x: -40, y: 28)
                    .padding(-20)
                    ForEach((item.steps[currentStep].text.keys).sorted(), id: \.self) { key in
                        Text(key)
                            .H5Style()
                            .foregroundColor(black)
                        Text(item.steps[currentStep].text[key]!)
                            .BodyStyle()
                            .foregroundColor(gray6)
                            .padding(.bottom, 12)
                    }
                }
            }.padding()
            .padding(.top, -20)
            
            Spacer()
        }
    }
}
