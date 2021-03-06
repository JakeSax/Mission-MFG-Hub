//
//  BaseViews.swift
//  Mission MFG Hub
//
//  Created by Jacob Sax on 2/8/21.
//


import SwiftUI

// Rect w some corners rounded w optional stroke & shadow
struct RoundedRect: View {
    var color: Color = .white
    var strokeColor: Color = .clear
    var strokeWidth: CGFloat = 1
    var shadowColor: Color = .clear
    var shadowRadius: CGFloat = 12
    var shadowX: CGFloat = 0
    var shadowY: CGFloat = 6
    var topLeft: CGFloat = 0.0
    var topRight: CGFloat = 0.0
    var bottomRight: CGFloat = 0.0
    var bottomLeft: CGFloat = 0.0
    
    var body: some View {
        Group {
            GeometryReader { geometry in
                Path { path in
                    
                    let w = geometry.size.width
                    let h = geometry.size.height
                    
                    // Make sure we do not exceed the size of the rectangle
                    let tr = min(min(self.topRight, h/2), w/2)
                    let tl = min(min(self.topLeft, h/2), w/2)
                    let bl = min(min(self.bottomLeft, h/2), w/2)
                    let br = min(min(self.bottomRight, h/2), w/2)
                    
                    path.move(to: CGPoint(x: w / 2.0, y: 0))
                    path.addLine(to: CGPoint(x: w - tr, y: 0))
                    path.addArc(center: CGPoint(x: w - tr, y: tr), radius: tr, startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)
                    path.addLine(to: CGPoint(x: w, y: h - br))
                    path.addArc(center: CGPoint(x: w - br, y: h - br), radius: br, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
                    path.addLine(to: CGPoint(x: bl, y: h))
                    path.addArc(center: CGPoint(x: bl, y: h - bl), radius: bl, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
                    path.addLine(to: CGPoint(x: 0, y: tl))
                    path.addArc(center: CGPoint(x: tl, y: tl), radius: tl, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)
                }
                .fill(self.color)
                .shadow(color: shadowColor, radius: shadowRadius, x: shadowX, y: shadowY)
                .overlay(
                    Path { path in
                        
                        let w = geometry.size.width
                        let h = geometry.size.height
                        
                        // Make sure we do not exceed the size of the rectangle
                        let tr = min(min(self.topRight, h/2), w/2)
                        let tl = min(min(self.topLeft, h/2), w/2)
                        let bl = min(min(self.bottomLeft, h/2), w/2)
                        let br = min(min(self.bottomRight, h/2), w/2)
                        
                        path.move(to: CGPoint(x: w / 2.0, y: 0))
                        path.addLine(to: CGPoint(x: w - tr, y: 0))
                        path.addArc(center: CGPoint(x: w - tr, y: tr), radius: tr, startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)
                        path.addLine(to: CGPoint(x: w, y: h - br))
                        path.addArc(center: CGPoint(x: w - br, y: h - br), radius: br, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
                        path.addLine(to: CGPoint(x: bl, y: h))
                        path.addArc(center: CGPoint(x: bl, y: h - bl), radius: bl, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
                        path.addLine(to: CGPoint(x: 0, y: tl))
                        path.addArc(center: CGPoint(x: tl, y: tl), radius: tl, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)
                        path.addLine(to: CGPoint(x: w/2, y: 0)) // added to this finish stroke
                    }.stroke(strokeColor, lineWidth: strokeWidth)
                )
            }
        }
    }
}

// Basic Text that can be edited by double click, with optional onCommit functions and uneditable preceding text
// press CMD+ENTER to commit text
struct EditableTextStyle: View {
    var precedingText: String?
    @State var text: String
    @State private var isEditing: Bool = false
    @State private var editedText: String = ""
    
    var textColor: Color = black
    var editingTextColor: Color = black
    var onCommit: () -> Void = {}
    var effectOnHover: Brightness = .darken
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            if precedingText != nil {
                if let safeText = precedingText {
                    Text(safeText)
                        .foregroundColor(textColor)
                }
            }
            
            ZStack(alignment: .topLeading) {
                Button("", action: {isEditing = false})
                    .hidden()
                    .keyboardShortcut(KeyEquivalent.return)
                
                TextField(editedText, text: $editedText)
                    .opacity(isEditing ? 1 : 0)
                    .textFieldStyle(PlainTextFieldStyle())
                    .foregroundColor(editingTextColor)
                
                Text(text)
                    .opacity(isEditing ? 0 : 1)
                    .foregroundColor(textColor)
            }
            
            .onAppear(perform: {
                editedText = text
            })
            
            .onChange(of: isEditing, perform: { value in
                print("is Editing: \(isEditing)")
                if isEditing == false {
                    onCommit()
                    text = editedText
                }
            })
            
            .onHoverBrightness(effect: effectOnHover)
        }.onTapGesture(count: 2, perform: {
            withAnimation { isEditing.toggle() }
        })
        
    }
}

func TextEditable( _ text: String, precedingText: String? = nil, textColor: Color = black, editingTextColor: Color = black, onCommit: @escaping () -> Void = {}, effectOnHover: Brightness = .lighten) -> some View {
    return EditableTextStyle(precedingText: precedingText, text: text, textColor: textColor, editingTextColor: editingTextColor, onCommit: onCommit, effectOnHover: effectOnHover)
}


// Horizontal Binary Toggle View
struct TextToggle: View {
    var textLeft: String = "On"
    var textRight: String = "Off"
    var textColorActive: Color = white
    var textColorInactive: Color = gray4
    var colorActive: Color = gray7
    var colorInactive: Color = gray1
    var cornerRadius: CGFloat = 24
    var verticalPadding: CGFloat = 10
    var horizontalPadding: CGFloat = 32
    
    @Binding var leftPressed: Bool
    
    var body: some View {
        ZStack {
            // BKGD RECT
            RoundedRectangle(cornerRadius: cornerRadius)
                .shadow(color: shadowGray, radius: 12, x: 0, y: 5)
            
            HStack(alignment: .center, spacing: 0) {
                
                // LEFT BUTTON
                ZStack {
                    RoundedRect(color: leftPressed ? colorActive : colorInactive, topLeft: cornerRadius, topRight: 0, bottomRight: 0, bottomLeft: cornerRadius)
                    Text(textLeft)
                        .foregroundColor(leftPressed ? textColorActive : textColorInactive)
                        .H6Style()
                        .padding(EdgeInsets(top: verticalPadding, leading: horizontalPadding, bottom: verticalPadding, trailing: horizontalPadding))
                }.onTapGesture(perform: { withAnimation {
                    leftPressed = true
                }})
                
                // RIGHT BUTTON
                ZStack {
                    RoundedRect(color: leftPressed ? colorInactive : colorActive, topLeft: 0, topRight: cornerRadius, bottomRight: cornerRadius, bottomLeft: 0)
                    Text(textRight)
                        .foregroundColor(leftPressed ? textColorInactive : textColorActive)
                        .H6Style()
                        .padding(EdgeInsets(top: verticalPadding, leading: horizontalPadding, bottom: verticalPadding, trailing: horizontalPadding))
                }.onTapGesture(perform: { withAnimation {
                    leftPressed = false
                }})
            }
        }
    }
}


struct BackButton: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var backButtonAction: () -> Void
    var backButtonType: BackButtonType = .leftArrow
    var size: CGFloat  {
        if backButtonType == .leftArrow { return 24 }
        if backButtonType == .xMark { return 26 }
        if backButtonType == .xMarkFill { return 26 }
        if backButtonType == .leftChevron { return 20 }
        return 24
    }
    
    var body: some View {
        Button(action: {
            self.backButtonAction()
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: self.backButtonType.rawValue)
                .font(.system(size: size, weight: .regular))
                .foregroundColor(.black)
        }
    }
    
    enum BackButtonType: String {
        case leftArrow = "arrow.left"
        case xMarkFill = "xmark.circle.fill"
        case xMark = "xmark.circle"
        case leftChevron = "chevron.left"
    }
}


struct Line: View {
    var minWidth: CGFloat = 0
    var width: CGFloat
    var maxWidth: CGFloat = .infinity
    var height: CGFloat = 1
    var color: Color = gray6
    var alignment: Alignment = .center
    var body: some View {
        RoundedRectangle(cornerRadius: 1)
            .frame(minWidth: width, idealWidth: width, maxWidth: maxWidth, minHeight: 1, idealHeight: height, maxHeight: height, alignment: alignment)
            .foregroundColor(color)
    }
}

struct VLine: View {
    var height: CGFloat
    var width: CGFloat = 1
    var color: Color = black
    
    var body: some View {
        RoundedRectangle(cornerRadius: 1)
            .frame(width: width, height: height, alignment: .center)
            .foregroundColor(color)
    }
}

struct Tile: View {
    var width: CGFloat
    var height: CGFloat
    var color: Color = gray1
    var strokeColor: Color = .black
    var shadowColor: Color = gray4
    var cornerRadius: CGFloat = 12
    var strokeWidth: CGFloat = 1
    var shadowY: CGFloat = 4
    
    var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(strokeColor, lineWidth: strokeWidth))
            .foregroundColor(color)
            .frame(width: width, height: height, alignment: .center)
            .shadow(color: shadowColor, radius: 8, x: 0, y: shadowY)
    }
}

struct AdaptiveTile: View {
    var minWidth: CGFloat
    var idealWidth: CGFloat
    var maxWidth: CGFloat
    var minHeight: CGFloat
    var idealHeight: CGFloat
    var maxHeight: CGFloat
    var color: Color = gray1
    var strokeColor: Color = .black
    var shadowColor: Color = gray4
    var cornerRadius: CGFloat = 12
    var strokeWidth: CGFloat = 1
    var shadowY: CGFloat = 4
    
    var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .foregroundColor(color)
            .frame(minWidth: minWidth, idealWidth: idealWidth, maxWidth: maxWidth, minHeight: minHeight, idealHeight: idealHeight, maxHeight: maxHeight, alignment: .center)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(strokeColor, lineWidth: strokeWidth))
            .shadow(color: shadowColor, radius: 8, x: 0, y: shadowY)
    }
}

struct SimpleAlertView: View {
    var text: String
    var body: some View {
        Tile(width: 300, height: 100, color: gray1, strokeColor: .black, strokeWidth: 1.2, shadowY: 8)
            .overlay(
                Text(text)
                    .lineSpacing(2)
                    .modifier(BodyText())
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
            )
    }
}


// Simple set of text views set side by side allowing two different colors 
struct TextPair: View {
    var text1: String
    var text2: String
    var color1: Color
    var color2: Color
    
    var body: some View {
        HStack(alignment: .center, spacing: 0, content: {
            Text(text1)
                .foregroundColor(color1)
            Text(text2)
                .foregroundColor(color2)
        })
    }
}
