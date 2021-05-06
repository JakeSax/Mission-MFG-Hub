//
//  StepHeader.swift
//  Mission MFG Hub
//
//  Created by Jacob Sax on 2/11/21.
//

import SwiftUI

struct StepHeader: View {
    @ObservedObject var item: Item
    @Binding var currentStep: Int
    @State var taskTime: String = "Enter Time"
    var body: some View {
        Group {
            HStack {
                Text(item.steps[currentStep].title)
                    .padding()
                    .H4Style()
                    .foregroundColor(gray7)
                Spacer()
                Line(width: 180, maxWidth: 200, color: gray3)
                Spacer()
                ArrowButtonPair(index: $currentStep, max: item.steps.count)
            }.padding(EdgeInsets(top: 0, leading: 0, bottom: -8, trailing: 12))
            
            
            HStack {
                Text("Machine: \(item.steps[currentStep].machine)")
                Spacer()
                Text("Time: \(taskTime)")
                    .onTapGesture(perform: { // converts to hours/mins
                                    taskTime = item.steps[currentStep].convertTime(str: taskTime) })
                    .darkenOnHover()
                    
                Spacer()
                Text("Program: \(item.steps[currentStep].program)")
            }.LabelStyle()
            .foregroundColor(gray6)
            .padding()
            .padding(.bottom, -12)
//            .transition(.moveUpWardsWhileFadingIn)
            
            Line(width: 660, color: gray3).padding()
                .padding(.bottom, 8)
        }.onChange(of: currentStep, perform: { value in // update time according to step
            taskTime = item.steps[currentStep].calculateTime(qty: item.qty)
            item.currentStep = currentStep
        })
        .onAppear(perform: {
            taskTime = item.steps[currentStep].calculateTime(qty: item.qty)
        })
    }
}

