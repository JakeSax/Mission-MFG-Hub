//
//  Buttons.swift
//  
//
//  Created by Jacob Sax on 2/8/21.
//

import SwiftUI

struct TextButton: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(configuration.isPressed ? gray7 : white)
            .padding()
            .background(configuration.isPressed ? white : gray7)
            .cornerRadius(8.0)
    }
}


struct IconButtonStyle: ButtonStyle {
    var defaultColor: Color = gray7
    var pressedColor: Color = gray4
    var bkgdColor: Color = white // color behind the icon, for transparent icons w shadows
    var shadowColor: Color = shadowGray
    var innerPadding: CGFloat = 4 // used to push bkgd color inside bounds of icon
    @State var scale: CGFloat = 1.15
    var scaleDuration: Double = 0.2
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(configuration.isPressed ? pressedColor : defaultColor)
            .background(
                bkgdColor
                    .padding(innerPadding) // to push bkgd color inside bounds of icon
                    .shadow(color: shadowColor, radius: 8, x: 0, y: 4)
            )
            .scaleEffect(configuration.isPressed ? scale : 1).animation(.easeInOut(duration: scaleDuration))
    }
}

struct IconButton: View {
    @Binding var isActive: Bool // was State
    var activeAction: () -> Void
    var image: String
    
    var body: some View {
        Button(action: {
            withAnimation {
                if isActive { activeAction() }
                else { print("Button Inactive") } }
        }, label: {
            Image(systemName: image).font(Font.system(size: 32, weight: .regular, design: .default))
        }).buttonStyle(IconButtonStyle())
        .opacity(isActive ? 1 : 0.4)
    }
}

struct ArrowButtonPair: View {
    @Binding var index: Int
    @State var max: Int
    @State var leftActive: Bool = false
    @State var rightActive: Bool = true
    var body: some View {
        Group {
            IconButton(isActive: $leftActive, activeAction: { index -= 1 }, image: "chevron.left.square.fill")
            IconButton(isActive: $rightActive, activeAction: { index += 1 } , image: "chevron.right.square.fill")
        }.onAppear(perform: {
            checkState()
        })
        .onChange(of: index, perform: { value in
            checkState()
        })
    }

    func checkState() {
        leftActive = index > 0
        rightActive = index < (max - 1)
    }
}

//struct LeftArrowButton: View {
//    @Binding var isActiveWhen: Bool
//    var activeAction: () -> Void
//    var body: some View {
//        IconButton(isActive: $isActiveWhen, activeAction: activeAction, image: "chevron.left.square.fill")
//    }
//}
//
//struct RightArrowButton: View {
//    @Binding var isActiveWhen: Bool
//    var activeAction: () -> Void
//    var body: some View {
//        IconButton(isActive: $isActiveWhen, activeAction: activeAction, image: "chevron.right.square.fill")
//    }
//}


struct EditButton: View {
    var image = "pencil.circle"
    var body: some View {
        Button(action: {
            print("edit text")
        }, label: {
            Image(systemName: image)
                .font(Font.system(size: 32, weight: .regular, design: .default))
        }).buttonStyle(IconButtonStyle(defaultColor: gray6, pressedColor: gray4, bkgdColor: .clear, shadowColor: .clear))
    }
}

struct RefreshButton: View {
    var image = "arrow.triangle.2.circlepath.circle"
    var action: () -> Void
    @State var rotation: Double = 0
    var body: some View {
        Button(action: {
            withAnimation(.easeInOut(duration: 1.1)) {
                action()
                print("refresh info")
                rotation += 720
            }
        }, label: {
            Image(systemName: image)
                .font(Font.system(size: 32, weight: .regular, design: .default))
        }).buttonStyle(IconButtonStyle(defaultColor: gray6, pressedColor: gray4, bkgdColor: .clear, shadowColor: .clear, scale: 1.3, scaleDuration: 0.45))
        .rotationEffect(.degrees(rotation))
    }
}

