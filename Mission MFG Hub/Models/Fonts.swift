//
//  Fonts.swift
//  Mission MFG Hub
//
//  Created by Jacob Sax on 2/8/21.
//

import SwiftUI

struct H1: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Telegraf Bold", size: 72))
    }
}

struct H2: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Telegraf Bold", size: 60))
    }
}

struct H3: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Telegraf Bold", size: 48))
    }
}

struct H4: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Telegraf Bold", size: 36))
    }
}

struct H5: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Telegraf Bold", size: 28))
    }
}

struct H6: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Telegraf Bold", size: 22))
    }
}

struct BodyText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Object Sans", size: 20))
            .lineSpacing(10)
    }
}

struct SmallBodyText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Object Sans", size: 16))
            .lineSpacing(3.5)
    }
}

//
//struct FlavorText: ViewModifier {
//    func body(content: Content) -> some View {
//        content
//            .font(.system(size: 14, weight: .light, design: .default))
//            .lineSpacing(3)
//    }
//}


//
//struct Button1: ViewModifier {
//    func body(content: Content) -> some View {
//        content
//            .font(Font.custom("SF Compact Text Light", size: 18))
//    }
//}

//struct Button2: ViewModifier {
//    func body(content: Content) -> some View {
//        content
//            .font(.system(size: 24, weight: .light, design: .default))
//    }
//}

struct LabelText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Object Sans", size: 22))
            .textCase(.uppercase)
    }
}

//struct SmallLabel: ViewModifier {
//    func body(content: Content) -> some View {
//        content
//            .font(Font.custom("SF Compact Text", size: 14))
//    }
//}
//

extension View {
    func H1Style() -> some View {
        self.modifier(H1())
    }
    func H2Style() -> some View {
        self.modifier(H2())
    }
    func H3Style() -> some View {
        self.modifier(H3())
    }
    func H4Style() -> some View {
        self.modifier(H4())
    }
    func H5Style() -> some View {
        self.modifier(H5())
    }
    func H6Style() -> some View {
        self.modifier(H5())
    }
    func BodyStyle() -> some View {
        self.modifier(BodyText())
    }
    func SmallBodyStyle() -> some View {
        self.modifier(SmallBodyText())
    }
    
    //    func Button1Style() -> some View {
    //        self.modifier(Button1())
    //    }
    //    func Button2Style() -> some View {
    //        self.modifier(Button2())
    //    }
    func LabelStyle() -> some View {
        self.modifier(LabelText())
    }
    //    func SmallLabelStyle() -> some View {
    //        self.modifier(SmallLabel())
    //    }
}

