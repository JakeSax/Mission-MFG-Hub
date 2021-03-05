//
//  ItemView.swift
//  Mission MFG Hub
//
//  Created by Jacob Sax on 2/8/21.
//

import SwiftUI

struct ItemView: View {
    @State var item: Item
    @State var currentStep: Int = 0
    
    var body: some View {
        ZStack {
            white
                .onAppear(perform: { updateView() })
            HStack {
                
                // MARK: - Part Info
                VStack(alignment: .leading, spacing: 0) {
                    
                    ItemHeader(item: item).transition(.moveUpWardsWhileFadingIn)
                    
                    StepHeader(item: $item, currentStep: $currentStep)
                    
                    StepTextListView(item: $item, currentStep: $currentStep, refreshAction: updateView, editAction: edit)
                    
                }.padding()
                
                // MARK: - Photos
                PhotoView(item: $item, currentStep: $currentStep)
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ItemView(item: testItem)
    }
}

enum PhotoChoice {
    case print
    case steps
}

extension ItemView {
    func updateView() {
//        item.steps[currentStep].calculateTime(qty: item.qty)
        print("whatever update you gotta do")
    }
    
    func edit() {
        print("edit. - add function here")
    }
}



