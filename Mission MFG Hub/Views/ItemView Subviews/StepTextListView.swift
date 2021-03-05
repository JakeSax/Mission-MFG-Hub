//
//  StepTextListView.swift
//  Mission MFG Hub
//
//  Created by Jacob Sax on 2/11/21.
//

import SwiftUI

struct StepTextListView: View {
    
    @Binding var item: Item
    @Binding var currentStep: Int
    @State var isEditing: Bool = false
    @State var text: [String:String] = ["Header":"Body"]
    @State var headerText: String = ""
    @State var bodyText: String = ""
    var refreshAction: () -> Void
    var editAction: () -> Void
    
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
//                    ForEach((item.steps[currentStep].text.keys).sorted(), id: \.self) { key in
                    ForEach((text.keys).sorted(), id: \.self) { key in
//                        if !isEditing {
                        Text(key)
                            .H5Style()
                            .foregroundColor(black)
                            .onTapGesture(count: 2, perform: {
                                withAnimation { isEditing.toggle() }
                            })
                            .overlay(
                                TextField(key, text: $headerText)
                                    .H5Style()
                                    .foregroundColor(.clear)
                                    .background(white.opacity(0))
                                    .opacity(isEditing ? 1 : 0)
                                    .onChange(of: headerText, perform: { value in
//                                        key = headerText
                                    })
                            )
//                        Text(item.steps[currentStep].text[key]!)
                        Text(text[key]!)
                            .BodyStyle()
                            .foregroundColor(gray6)
                            .padding(.bottom, 16)
                            .onTapGesture(count: 2, perform: {
                                withAnimation { isEditing.toggle() }
                            })
//                        }
//                        if isEditing {
//                            TextField(key, text: $headerText)
//                                .H5Style()
//                                .foregroundColor(black)
//                                .background(gray1.opacity(0))
//                                .overlay(
//                                    Text(key)
//                                        .H5Style()
//                                        .foregroundColor(black)
//                                        .leftAlign()
//                                        .onTapGesture(count: 2, perform: {
//                                            withAnimation { isEditing.toggle() }
//                                        })
//                                        )
                            
                                
//                            TextEditor(text: $bodyText)
//                                .BodyStyle()
//                                .foregroundColor(gray6)
//                                .background(gray1)
//                                .padding(.bottom, 16)
//                        }
                    }
                }
            }.padding()
            .padding(.top, -20)
            .onAppear(perform: {
                withAnimation{ text = item.steps[currentStep].text }
            })
            .onChange(of: isEditing, perform: { value in
                item.steps[currentStep].text = text
                print("Item: \(item.steps[currentStep].text)")
            })
            
            
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
        text["Add Header Here"] = "Add step text here"
    }
}

