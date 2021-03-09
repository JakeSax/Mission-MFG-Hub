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
                    }.stroke(strokeColor, lineWidth: strokeWidth)
                )
            }
        }
    }
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
