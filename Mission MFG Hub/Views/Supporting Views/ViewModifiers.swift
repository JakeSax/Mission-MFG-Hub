//
//  ViewModifiers.swift
//  Mission MFG Hub
//
//  Created by Jacob Sax on 2/8/21.
//


import SwiftUI


//MARK: - UI Modifiers

struct shadow1: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: gray4, radius: 8, x: 0, y: 4)
    }
}

// For rounded rectangles 
struct strokeAndShadowMod: ViewModifier {
    var cornerRadius: CGFloat = 12
    var strokeColor: Color = .black
    var strokeWidth: CGFloat = 1
    var shadowColor: Color = gray4
    var shadowY: CGFloat = 4
    var shadowX: CGFloat = 0
    var shadowRadius: CGFloat = 8
    
    func body(content: Content) -> some View {
        content
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(strokeColor, lineWidth: strokeWidth))
            .shadow(color: shadowColor, radius: shadowRadius, x: shadowX, y: shadowY)
    }
}

struct darkenOnHoverMod: ViewModifier {
    @State var isHovering: Bool = false
    func body(content: Content) -> some View {
        content
            .brightness(isHovering ? -0.2 : 0)
            .onHover(perform: { hovering in
                withAnimation(.easeInOut(duration: 0.035)) {
                self.isHovering = hovering
                }
            })
    }
}

struct lightenOnHoverMod: ViewModifier {
    @State var isHovering: Bool = false
    func body(content: Content) -> some View {
        content
            .brightness(isHovering ? 0.2 : 0)
            .onHover(perform: { hovering in
                withAnimation(.easeInOut(duration: 0.035)) {
                self.isHovering = hovering
                }
            })
    }
}

struct hoverMod: ViewModifier {
    @State var isHovering: Bool = false
    var brightness: Brightness = .darken
    func body(content: Content) -> some View {
        content
            .brightness(isHovering ? (checkBrightness(brightness) ? -0.3 : 0.3) : 0)
            .onHover(perform: { hovering in
                withAnimation(.easeInOut(duration: 0.035)) {
                self.isHovering = hovering
                }
            })
    }
    
    func checkBrightness(_ brightness: Brightness) -> Bool {
        if brightness == .darken {
            return true
        }
        else {
            return false
        }
    }
    
}


struct leftAlignMod: ViewModifier {
    func body(content: Content) -> some View {
        HStack {
            content
            Spacer()
        }
    }
}

struct rightAlignMod: ViewModifier {
    func body(content: Content) -> some View {
        HStack {
            Spacer()
            content
        }
    }
}

struct topAlignMod: ViewModifier {
    func body(content: Content) -> some View {
        VStack {
            content
            Spacer()
        }
    }
}


struct bottomAlignMod: ViewModifier {
    func body(content: Content) -> some View {
        VStack {
            Spacer()
            content
        }
    }
}

struct HCenterAlignMod: ViewModifier {
    func body(content: Content) -> some View {
        HStack {
            Spacer()
            content
            Spacer()
        }
    }
}

struct VCenterAlignMod: ViewModifier {
    func body(content: Content) -> some View {
        VStack {
            Spacer()
            content
            Spacer()
        }
    }
}

extension View {
    func rightAlign() -> some View {
        self.modifier(rightAlignMod())
    }
    func leftAlign() -> some View {
        self.modifier(leftAlignMod())
    }
    func topAlign() -> some View {
        self.modifier(topAlignMod())
    }
    func bottomAlign() -> some View {
        self.modifier(bottomAlignMod())
    }
    func HCenterAlign() -> some View {
        self.modifier(HCenterAlignMod())
    }
    func VCenterAlign() -> some View {
        self.modifier(VCenterAlignMod())
    }
    func darkenOnHover() -> some View {
        self.modifier(darkenOnHoverMod())
    }
    func lightenOnHover() -> some View {
        self.modifier(lightenOnHoverMod())
    }
    func strokeAndShadow(cornerRadius: CGFloat = 12, strokeColor: Color = .black, strokeWidth: CGFloat = 1, shadowColor: Color = gray4,  shadowY: CGFloat = 4, shadowX: CGFloat = 0, shadowRadius: CGFloat = 8) -> some View {
        self.modifier(strokeAndShadowMod(cornerRadius: cornerRadius, strokeColor: strokeColor, strokeWidth: strokeWidth, shadowColor: shadowColor,  shadowY: shadowY, shadowX: shadowX, shadowRadius: shadowRadius))
    }
    func onHoverBrightness(effect: Brightness = .darken) -> some View {
        self.modifier(hoverMod(brightness: effect))
    }
    
}
