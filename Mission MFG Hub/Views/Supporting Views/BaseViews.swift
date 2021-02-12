//
//  BaseViews.swift
//  Mission MFG Hub
//
//  Created by Jacob Sax on 2/8/21.
//


import SwiftUI

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
}

extension BackButton {
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
//            .frame(width: width, height: height, alignment: alignment)
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
