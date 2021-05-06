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
    @State var willDelete: Bool = false
    @State var stepText : [StepText]
    
    var body: some View {
        Group {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Group {
                        AddTextButton(isActive: $isEditing, action: addText)
                        MinusButton(isActive: $isEditing, action: { willDelete.toggle() })
                        EditButton(action: { edit() })
                    }.rightAlign()
                    .offset(x: -20, y: 28)
                    .padding(-20)
                    
                    ForEach(0..<stepText.count, id: \.self) { index in
                        HStack(alignment: .center, spacing: 12) {
                            if willDelete {
                                RemoveTextButton(isActive: $willDelete, action: { self.removeText(at: index) } )
                            }
                            StepTextPair(isEditing: $isEditing, stepText: $stepText[index])
                        }
                    }
//                    ForEach(item.steps[currentStep].text.indices, id: \.self) { index in
//                        HStack(alignment: .center, spacing: 12) {
//                            if willDelete {
//                                RemoveTextButton(isActive: $isEditing, action: { self.removeText(at: self.stepText.firstIndex(where: { $0.id == item.steps[currentStep].text[index].id })!)} )
//                            }
//                            StepTextPair(isEditing: $isEditing, stepText: $item.steps[currentStep].text[index])
//                        }
//                    }
                    .onDelete(perform: { indexSet in
                        removeTextFromIndexSet(at: indexSet)
                    })
                    .id(UUID())
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
        stepText = item.steps[step].text
    }
    func saveChanges(to step: Int) { // saves changes made to step
        item.steps[step].text = stepText
    }
    func edit() { // to edit the current step text
        if isEditing {
            saveChanges(to: currentStep)
        }
        isEditing.toggle()
    }
    func addText() { // to add a new text section to current step text
        stepText.append(StepText())
//        item.steps[currentStep].text.append(StepText())
    }
    func removeText(at index: Int) { // to remove text section
        stepText.remove(at: index)
//        item.steps[currentStep].text.remove(at: index)
    }
    func removeTextFromIndexSet(at indexSet: IndexSet) { // to remove text section
        stepText.remove(atOffsets: indexSet)
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

struct StepTextPair: View {
    @Binding var isEditing: Bool
    @Binding var stepText: StepText
    let id = UUID()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HeaderTextField(headerText: $stepText.header, isEditing: $isEditing)
            BodyTextField(bodyText: $stepText.body, isEditing: $isEditing)
        }
    }
}
