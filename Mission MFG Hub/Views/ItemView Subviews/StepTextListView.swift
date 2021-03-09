//
//  StepTextListView.swift
//  Mission MFG Hub
//
//  Created by Jacob Sax on 2/11/21.
//

import SwiftUI

struct StepTextListView: View {
    
    @ObservedObject var item: Item
    @Binding var currentStep: Int
    @State var isEditing: Bool = false
    var refreshAction: () -> Void
    
    var body: some View {
        Group {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Group {
                        AddTextButton(isActive: $isEditing, action: addText)
                        RefreshButton(action:{ refreshAction() })
                        EditButton(action: { edit() })
                    }.rightAlign()
                    .offset(x: -20, y: 28)
                    .padding(-20)
                    
                    ForEach(item.steps[currentStep].text.indices, id: \.self) { idx in
                        HeaderTextField(headerText: item.steps[currentStep].text[idx].header, isEditing: $isEditing)
                        BodyTextField(bodyText: item.steps[currentStep].text[idx].body, isEditing: $isEditing)
                    }
                    .onChange(of: currentStep, perform: { value in
                        // commit text to current step and get new text for new step
                        isEditing = false
                    })
                }
            }.padding()
            .padding(.top, -20)
            
            Spacer()
        }.background(
            RoundedRectangle(cornerRadius: 16)
                .foregroundColor(isEditing ? gray1 : white)
                .strokeAndShadow(strokeColor: isEditing ? gray6 : .clear, shadowColor: isEditing ? shadowGray : .clear)
                .offset(x: 0, y: -8)
        )
    }
}


extension StepTextListView {
    func edit() {
        isEditing.toggle()
    }
    func addText() {
        item.steps[currentStep].text.append(StepText())
    }
}


extension NSTextView {
    open override var frame: CGRect {
        didSet {
            backgroundColor = .clear // This makes the background of text fields empty
            drawsBackground = true
            insertionPointColor = .black // This makes the text cursor black
        }
    }
}
