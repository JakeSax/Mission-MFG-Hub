//
//  ItemView.swift
//  Mission MFG Hub
//
//  Created by Jacob Sax on 2/8/21.
//

import SwiftUI

struct ItemView: View {
    @StateObject var item: Item
    @State var currentStep: Int = 0
    @State var order: Order
    var ideal: CGFloat = 600
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            white
                .onAppear(perform: { updateView() })
            HStack(alignment: .top) {
                
                // MARK: - Part Info
                VStack(alignment: .leading, spacing: 0) {
                    
                    ItemHeader(item: item).transition(.moveUpWardsWhileFadingIn)
                    
                    StepHeader(item: item, currentStep: $currentStep)
                    
                    StepTextListView(item: item, currentStep: $currentStep, stepText: item.steps[currentStep].text)
                    
                }.padding()
//                .frame(width: 800, alignment: .leading)
                .frame(minWidth: 400, idealWidth: 600, maxWidth: 600, alignment: .leading)
                Spacer()
                // MARK: - Photos & Order Info
                VStack {
                    PhotoView(item: item, currentStep: $currentStep)
//                        .frame(minWidth: 400, idealWidth: ideal, maxWidth: ideal)
                    OrderInfoView(item: item, customer: order.customerName, dueDate: order.dueDateString)
                }.padding([.leading, .trailing], 32)
                .frame(minWidth: 400, idealWidth: 1080, maxWidth: 1080)
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ItemView(item: testItem, order: testOrder)
    }
}

extension ItemView {
    func updateView() {
        // get current step
    }
}



