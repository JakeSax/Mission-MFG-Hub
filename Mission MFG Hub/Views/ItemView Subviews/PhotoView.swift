//
//  PhotoView.swift
//  Mission MFG Hub
//
//  Created by Jacob Sax on 2/11/21.
//

import SwiftUI

struct PhotoView: View {
    @Binding var item: Item
    @Binding var currentStep: Int
    @State var photoChoice: PhotoChoice = .steps
    @State var photoNum: Int = 0
    @State var isHovering: Bool = false
    var body: some View {
        VStack{
            ZStack {
                if photoChoice == .print {
                    (item.steps[currentStep].print.0)
                        .resizable()
                        .scaledToFill()
                        .opacity(0.8)
                }
                
                if photoChoice == .steps {
                    // Show step photo and arrow buttons
                    (item.steps[currentStep].images[photoNum].0)
                        .resizable()
                        .scaledToFill()
                        .onHover(perform: { hovering in
                            withAnimation { isHovering = hovering }
                        })
                    VStack {
                        HStack {
                            if isHovering {
                                Text(item.steps[currentStep].images[photoNum].1)
                                    .BodyStyle()
                                    .foregroundColor(white)
                                    .background(black.opacity(0.8).blur(radius: 20).padding(EdgeInsets(top: -4, leading: -20, bottom: -4, trailing: -20)))
                                    .padding(EdgeInsets(top: 36, leading: 48, bottom: 0, trailing: 0))
                            }
                            Spacer()
                        }
                        Spacer()
                        HStack {
                            Spacer()
                            ArrowButtonPair(index: $photoNum, max: item.steps[currentStep].images.count - 1)
                        }.padding(EdgeInsets(top: 0, leading: 0, bottom: 32, trailing: 40))
                    }.padding()
                }
            }.padding()
            .frame(width: 900, height: 600, alignment: .center)
//            .frame(width: 1200, height: 800, alignment: .center)
            Spacer()
        }.padding()
    }
}
