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
    @State var text : [StepText]
    
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
                    
                    ForEach(text.indices, id: \.self) { index in
                            HeaderTextField(headerText: text[index].header, isEditing: $isEditing)
                            BodyTextField(bodyText: text[index].body, isEditing: $isEditing)
                    }.id(UUID())
                    .transition(.textTransitionVert)
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
        .onAppear(perform: {
            updateText(to: currentStep)
        })
        .onChange(of: currentStep, perform: { newStep in
            isEditing = false
            updateText(to: newStep)
        })
    }
}


extension StepTextListView {
    func updateText(to step: Int) { // updates text to current step text
        text = item.steps[step].text
    }
    func saveChanges(to step: Int) { // saves changes made to step
        item.steps[step].text = text
    }
    func edit() { // to edit the current step text
        isEditing.toggle()
        if !isEditing {
            saveChanges(to: currentStep)
        }
    }
    func addText() { // to add a new text section to current step text
        text.append(StepText())
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
