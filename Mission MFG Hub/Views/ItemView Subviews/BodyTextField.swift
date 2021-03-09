//
//  BodyTextField.swift
//  Mission MFG Hub
//
//  Created by Jacob Sax on 3/5/21.
//

import SwiftUI

struct BodyTextField: View {
    @State var bodyText: String
    @Binding var isEditing: Bool
    
    var body: some View {
        ZStack(alignment: .topLeading){
            TextEditor(text: $bodyText)
                .accentColor(.black)
                .BodyStyle()
                .foregroundColor(black)
                .offset(x: -5, y: 0)
                .opacity(isEditing ? 1 : 0)
            Text(bodyText)
                .BodyStyle()
                .foregroundColor(gray6)
                .padding(.bottom, 16)
                .opacity(isEditing ? 0 : 1)
        }.onTapGesture(count: 2, perform: {
            withAnimation { isEditing.toggle() }
        })
    }
}
