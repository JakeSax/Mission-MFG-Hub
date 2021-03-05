//
//  HeaderTextField.swift
//  Mission MFG Hub
//
//  Created by Jacob Sax on 3/5/21.
//

import SwiftUI

struct HeaderTextField: View {
    @State var headerText: String = ""
    @State private var isEditing: Bool = false
    var body: some View {
        Text("Hello, World!")
            .H5Style()
            .foregroundColor(black)
            .onTapGesture(count: 2, perform: {
                withAnimation { isEditing.toggle() }
            })
    }
}

struct HeaderTextField_Previews: PreviewProvider {
    static var previews: some View {
        HeaderTextField()
    }
}
