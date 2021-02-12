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
    
}
