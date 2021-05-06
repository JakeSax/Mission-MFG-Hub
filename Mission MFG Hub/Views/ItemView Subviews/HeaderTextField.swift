//
//  HeaderTextField.swift
//  Mission MFG Hub
//
//  Created by Jacob Sax on 3/5/21.
//

import SwiftUI

struct HeaderTextField: View {
    @Binding var headerText: String
    @Binding var isEditing: Bool
    @State var editedText: String = ""
    let id = UUID()
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Button("", action: {isEditing = false})
                .hidden()
                .keyboardShortcut(KeyEquivalent.return)
            
            TextField(editedText, text: $editedText)
                .textFieldStyle(PlainTextFieldStyle())
                .H5Style()
                .foregroundColor(black)
                .opacity(isEditing ? 1 : 0)
                
            Text(headerText)
                .H5Style()
                .foregroundColor(black)
                .opacity(isEditing ? 0 : 1)
        }.frame(width: 575)
        .onTapGesture(count: 2, perform: {
            withAnimation { isEditing.toggle() }
        })
        .onAppear(perform: {
            editedText = headerText
        })
        .onChange(of: isEditing, perform: { value in
            if isEditing == false {
                headerText = editedText
            }
        })
    }
}
