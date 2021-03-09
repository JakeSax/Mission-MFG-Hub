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
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            white
                .onAppear(perform: { updateView() })
            HStack(alignment: .top) {
                
                // MARK: - Part Info
                VStack(alignment: .leading, spacing: 0) {
                    
                    ItemHeader(item: item).transition(.moveUpWardsWhileFadingIn)
                    
                    StepHeader(item: item, currentStep: $currentStep)
                    
                    StepTextListView(item: item, currentStep: $currentStep, refreshAction: updateView)
                    
                }.padding()
                .frame(width: 800, alignment: .leading)
                
                // MARK: - Photos
                PhotoView(item: item, currentStep: $currentStep)
                    //            .frame(width: 900, height: 600, alignment: .center)
                    .frame(width: 960, height: 640)
//                    .frame(width: 1080, height: 720)
                    //            .frame(width: 1200, height: 800, alignment: .center)
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ItemView(item: testItem)
    }
}

extension ItemView {
    func updateView() {
//        item.steps[currentStep].calculateTime(qty: item.qty)
//        print("whatever update you gotta do")
    }
}



