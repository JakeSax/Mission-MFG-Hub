//
//  Buttons.swift
//  
//
//  Created by Jacob Sax on 2/8/21.
//

import SwiftUI

// A simple button of text w a color behind it
struct TextButton: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(configuration.isPressed ? gray7 : white)
            .padding()
            .background(configuration.isPressed ? white : gray7)
            .cornerRadius(8.0)
    }
}

// a style of button with an icon as the button, usually an SF Symbol
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

// Button with a SF Symbol as the image, with an active state
struct IconButton: View {
    @Binding var isActive: Bool // was State
    var activeAction: () -> Void
    var image: String
    var size: CGFloat = 32
    var inactiveOpacity: Double = 0.4
    var animationAction: () -> Void = {}
    var animation: Animation = .easeInOut(duration: 0.3)
    var inactiveAction: () -> Void = {}
    var inactiveAnimation: Animation = .easeInOut(duration: 0.3)
    
    var defaultColor: Color = gray7
    var pressedColor: Color = gray4
    var bkgdColor: Color = white // color behind the icon, for transparent icons w shadows
    var shadowColor: Color = shadowGray
    var innerPadding: CGFloat = 4 // used to push bkgd color inside bounds of icon
    var scale: CGFloat = 1.15
    var scaleDuration: Double = 0.2
    
    var body: some View {
        Button(action: {
            if isActive {
                withAnimation(animation) {
                    activeAction()
                    animationAction()
                }
            }
            else {
                withAnimation(inactiveAnimation) {
                    print("Button Inactive")
                    inactiveAction()
                }
            }
        }, label: {
            Image(systemName: image).font(Font.system(size: size, weight: .regular, design: .default))
        }).buttonStyle(IconButtonStyle(defaultColor: defaultColor, pressedColor: pressedColor, bkgdColor: bkgdColor, shadowColor: shadowColor, innerPadding: innerPadding, scale: scale, scaleDuration: scaleDuration))
        .opacity(isActive ? 1 : inactiveOpacity)
    }
}

// Button with a SF Symbol as the image, always active
struct IconStatelessButton: View {
    var action: () -> Void
    var image: String
    var size: CGFloat = 32
    var animationAction: () -> Void = {}
    var animation: Animation = .easeInOut(duration: 0.3)
    
    var defaultColor: Color = gray7
    var pressedColor: Color = gray4
    var bkgdColor: Color = white // color behind the icon, for transparent icons w shadows
    var shadowColor: Color = shadowGray
    var innerPadding: CGFloat = 4 // used to push bkgd color inside bounds of icon
    var scale: CGFloat = 1.15
    var scaleDuration: Double = 0.2
    
    var body: some View {
        Button(action: {
                withAnimation(animation) {
                    action()
                    animationAction()
                }
        }, label: {
            Image(systemName: image).font(Font.system(size: size, weight: .regular, design: .default))
        }).buttonStyle(IconButtonStyle(defaultColor: defaultColor, pressedColor: pressedColor, bkgdColor: bkgdColor, shadowColor: shadowColor, innerPadding: innerPadding, scale: scale, scaleDuration: scaleDuration))
    }
    
}



// MARK: - ItemView & Subviews Buttons

// Pair of arrow buttons for basic navigation
struct ArrowButtonPair: View {
    @Binding var index: Int
    @State var max: Int
    @State var leftActive: Bool = false
    @State var rightActive: Bool = true
    let leftIconString = "chevron.left.square.fill"
    let rightIconString = "chevron.right.square.fill"
    
    var body: some View {
        Group {
            IconButton(isActive: $leftActive, activeAction: { index -= 1 }, image: leftIconString)
            IconButton(isActive: $rightActive, activeAction: { index += 1 } , image: rightIconString)
        }.onAppear(perform: { checkState() })
        .onChange(of: index, perform: { value in checkState() })
    }
    
    func checkState() { // checks whether the buttons should be active
        leftActive = index > 0
        rightActive = index < (max - 1)
    }
}

struct AddTextButton: View {
    let image = "plus.circle.fill"
    @Binding var isActive: Bool
    var action: () -> Void
    
    var body: some View {
        IconButton(isActive: $isActive, activeAction: action, image: image, size: 28, defaultColor: gray7, pressedColor: gray5, bkgdColor: .clear, shadowColor: .clear)
            .opacity(isActive ? 1 : 0)
            .lightenOnHover()
    }
}


struct EditButton: View {
    var image = "pencil.circle"
    var action: () -> Void
    var body: some View {
        IconStatelessButton(action: action, image: image, size: 28, defaultColor: gray7, pressedColor: gray5, bkgdColor: .clear, shadowColor: .clear)
            .darkenOnHover()
    }
}

struct RefreshButton: View {
    var image = "arrow.triangle.2.circlepath.circle"
    var action: () -> Void
    @State var rotation: Double = 0
    var body: some View {
        IconStatelessButton(action: action, image: image, size: 28, animationAction: {rotation += 720}, animation: .easeInOut(duration: 1.1), defaultColor: gray7, pressedColor: gray5, bkgdColor: .clear, shadowColor: .clear, scale: 1.3, scaleDuration: 0.45)
            .rotationEffect(.degrees(rotation))
            .darkenOnHover()
    }
}


//struct EditButton: View {
//    var image = "pencil.circle"
//    var action: () -> Void
//    var body: some View {
//        Button(action: {
//            withAnimation { action() }
//            print("edit text")
//        }, label: {
//            Image(systemName: image)
//                .font(Font.system(size: 28, weight: .regular, design: .default))
//        }).buttonStyle(IconButtonStyle(defaultColor: gray6, pressedColor: gray4, bkgdColor: .clear, shadowColor: .clear))
//        .darkenOnHover()
//    }
//}
//
//struct RefreshButton: View {
//    var image = "arrow.triangle.2.circlepath.circle"
//    var action: () -> Void
//    @State var rotation: Double = 0
//    var body: some View {
//        Button(action: {
//            withAnimation(.easeInOut(duration: 1.1)) {
//                action()
//                print("refresh info")
//                rotation += 720
//            }
//        }, label: {
//            Image(systemName: image)
//                .font(Font.system(size: 28, weight: .regular, design: .default))
//        }).buttonStyle(IconButtonStyle(defaultColor: gray6, pressedColor: gray4, bkgdColor: .clear, shadowColor: .clear, scale: 1.3, scaleDuration: 0.45))
//        .rotationEffect(.degrees(rotation))
//        .darkenOnHover()
//    }
//}



