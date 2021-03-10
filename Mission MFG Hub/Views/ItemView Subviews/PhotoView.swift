//
//  PhotoView.swift
//  Mission MFG Hub
//
//  Created by Jacob Sax on 2/11/21.
//

import SwiftUI

struct PhotoView: View {
    @ObservedObject var item: Item
    @Binding var currentStep: Int
    @State var showPrint: Bool = true
    @State var photoNum: Int = 0
    @State var isHovering: Bool = false
    @State var primaryImage: (image: Image, description: String)?
    
    var body: some View {
        VStack {
            ZStack {
                primaryImage?.image
                    .resizable()
                    .cornerRadius(24)
                    .shadow(color: shadowGrayLight, radius: 12, x: 0, y: 8)
                    .scaledToFill()
                    .onHover(perform: { hovering in
                        withAnimation { isHovering = hovering }
                    })
                if isHovering {
                    VStack {
                        HStack {
                            Text(primaryImage?.description ?? "No Description Added")
                                .BodyStyle()
                                .foregroundColor(white)
                                .background(black.opacity(0.9).blur(radius: 20).padding(EdgeInsets(top: -4, leading: -20, bottom: -4, trailing: -20)).offset(x: 0, y: -4))
                            Spacer()
                            TextToggle(textLeft: "Print", textRight: "Step", leftPressed: $showPrint)
                                .frame(width: 240, height: 40, alignment: .center)
                        }
                        Spacer()
                        
                        if !showPrint {
                            HStack {
                                Spacer()
                                ArrowButtonPair(index: $photoNum, max: item.steps[currentStep].images.count)
                            }
                        }
                        
                    }.padding(EdgeInsets(top: 36, leading: 56, bottom: 36, trailing: 40))
                }
            }
        }
        .padding(EdgeInsets(top: 48, leading: -12, bottom: 0, trailing: -12))
        
        .onChange(of: showPrint, perform: { value in withAnimation {
            if showPrint == true {
                primaryImage = (item.steps[currentStep].print)
            } else {
                primaryImage = item.steps[currentStep].images[photoNum]
            }}
        })
        .onAppear(perform: { withAnimation{
            primaryImage = item.steps[currentStep].print
        }})
        .onChange(of: photoNum, perform: { value in withAnimation {
            primaryImage = item.steps[currentStep].images[photoNum]
        }})
    }
}



