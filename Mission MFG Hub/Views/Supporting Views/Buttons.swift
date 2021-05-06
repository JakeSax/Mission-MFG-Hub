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
    var defaultColor: Color = gray7 // unpressed, default color
    var pressedColor: Color = gray4 // color while the button is pressed
    var bkgdColor: Color = white // color behind the icon, for transparent icons w shadows
    var shadowColor: Color = shadowGray
    var innerPadding: CGFloat = 4 // used to push bkgd color inside bounds of icon
    @State var scale: CGFloat = 1.15
    var scaleDuration: Double = 0.2
    @State private var toggled: Bool = false
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

// Button with a SF Symbol as the image, with an active/inactive state
struct IconStateButton: View {
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
    var pressedColor: Color = gray4 // color while the button is pressed
    var toggledColor: Color = gray7 // color the button changes to on press, if you want
    var bkgdColor: Color = white // color behind the icon, for transparent icons w shadows
    var shadowColor: Color = shadowGray
    var innerPadding: CGFloat = 4 // used to push bkgd color inside bounds of icon
    var scale: CGFloat = 1.15
    var scaleDuration: Double = 0.2
    
    @State private var isToggled: Bool = false
    
    var body: some View {
        Button(action: {
            if isActive {
                withAnimation(animation) {
                    activeAction()
                    animationAction()
                    isToggled.toggle()
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
        }).buttonStyle(IconButtonStyle(defaultColor: isToggled ? toggledColor : defaultColor, pressedColor: pressedColor, bkgdColor: bkgdColor, shadowColor: shadowColor, innerPadding: innerPadding, scale: scale, scaleDuration: scaleDuration))
        .opacity(isActive ? 1 : inactiveOpacity)
    }
}

// Button with a SF Symbol as the image, always active, optional toggle color
struct IconButton: View {
    var action: () -> Void
    var image: String
    var size: CGFloat = 32
    var animationAction: () -> Void = {}
    var animation: Animation = .easeInOut(duration: 0.3)
    
    var defaultColor: Color = gray7
    var pressedColor: Color = gray4
    var toggledColor: Color = gray7
    var bkgdColor: Color = white // color behind the icon, for transparent icons w shadows
    var shadowColor: Color = shadowGray
    var innerPadding: CGFloat = 4 // used to push bkgd color inside bounds of icon
    var scale: CGFloat = 1.15
    var scaleDuration: Double = 0.2
    
    @State private var isToggled: Bool = false
    
    var body: some View {
        Button(action: {
                withAnimation(animation) {
                    action()
                    animationAction()
                    isToggled.toggle()
                }
        }, label: {
            Image(systemName: image).font(Font.system(size: size, weight: .regular, design: .default))
        }).buttonStyle(IconButtonStyle(defaultColor: isToggled ? toggledColor : defaultColor, pressedColor: pressedColor, bkgdColor: bkgdColor, shadowColor: shadowColor, innerPadding: innerPadding, scale: scale, scaleDuration: scaleDuration))
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
            IconStateButton(isActive: $leftActive, activeAction: { index -= 1 }, image: leftIconString)
            IconStateButton(isActive: $rightActive, activeAction: { index += 1 } , image: rightIconString)
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
        IconStateButton(isActive: $isActive, activeAction: action, image: image, size: 28, defaultColor: gray7, pressedColor: gray5, bkgdColor: .clear, shadowColor: .clear)
            .opacity(isActive ? 1 : 0)
            .lightenOnHover()
    }
}

struct MinusButton: View {
    let image = "minus.circle.fill"
    @Binding var isActive: Bool
    var action: () -> Void
    
    var body: some View {
        IconStateButton(isActive: $isActive, activeAction: action, image: image, size: 28, defaultColor: gray7, pressedColor: gray5, bkgdColor: .clear, shadowColor: .clear)
            .opacity(isActive ? 1 : 0)
            .lightenOnHover()
            
    }
}



struct RemoveTextButton: View {
    let image = "minus.circle.fill"
    @Binding var isActive: Bool
    var action: () -> Void
    
    var body: some View {
        IconStateButton(isActive: $isActive, activeAction: action, image: image, size: 22, defaultColor: gray7, pressedColor: gray5, bkgdColor: .clear, shadowColor: .clear)
            .opacity(isActive ? 1 : 0)
            .lightenOnHover()
            .offset(x: 0, y: -1.5)
    }
}


struct EditButton: View {
    var image = "pencil.circle"
    var action: () -> Void
    
    var body: some View {
        IconButton(action: action, image: image, size: 28, defaultColor: gray7, pressedColor: gray5, toggledColor: .orange, bkgdColor: .clear, shadowColor: .clear)
            .lightenOnHover()
    }
}

struct RefreshButton: View {
    var image = "arrow.triangle.2.circlepath.circle"
    var action: () -> Void
    @State var rotation: Double = 0
    var body: some View {
        IconButton(action: action, image: image, size: 28, animationAction: {rotation += 720}, animation: .easeInOut(duration: 1.1), defaultColor: gray7, pressedColor: gray5, bkgdColor: .clear, shadowColor: .clear, scale: 1.3, scaleDuration: 0.45)
            .rotationEffect(.degrees(rotation))
            .lightenOnHover()
    }
}



