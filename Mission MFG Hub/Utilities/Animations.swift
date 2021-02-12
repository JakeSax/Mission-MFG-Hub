//
//  Animations.swift
//  Mission MFG Hub
//
//  Created by Jacob Sax on 2/8/21.
//



import SwiftUI

struct Transition1: ViewModifier {
    func body(content: Content) -> some View {
        content
            .transition(AnyTransition.asymmetric(insertion: AnyTransition.slide.combined(with: .opacity), removal: AnyTransition.move(edge: .bottom).combined(with: .opacity)))
    }
}

struct FadeInOnAppear: ViewModifier {
    @State var offsetAnimated: Bool = false
    @State var opacityAnimated: Bool = false
    var shouldAnimateOffset: Bool = true
    var shouldAnimateOpacity: Bool = true
    var durationOffset: Double = 0
    var dampingCoefficient: Double = 0.9
    
    let durationOffsetCoefficient: Double = 0.065  // 0.095
    let dampingOffsetCoefficient: Double = 0.015 // 0.015
    
    let responseTime: Double = 0.55
    let delayConstant: Double = 0.05
    let opacityTimeOffset: Double = 0.15
    
    func body(content: Content) -> some View {
        content
            .offset(y: offsetAnimated ? 0 : shouldAnimateOffset ? 30 : 0)
            .opacity(opacityAnimated ? 1 : shouldAnimateOpacity ? 0.0 : 1)
            .onAppear(perform: {
//                print("on appear, offset animated is \(offsetAnimated), opacity animated is \(opacityAnimated)")
                offsetAnimated = false
                withAnimation(Animation.spring(response: responseTime + (durationOffset*durationOffsetCoefficient), dampingFraction: (0.55*dampingCoefficient)+(durationOffset*durationOffsetCoefficient), blendDuration: 0.0).delay(delayConstant+0.06*durationOffset)) {
                    offsetAnimated = true
                }
                opacityAnimated = false
                withAnimation((Animation.easeInOut(duration: responseTime + opacityTimeOffset + (durationOffset*durationOffsetCoefficient*0.5)).delay(delayConstant+0.062*durationOffset))) {
                    opacityAnimated = true
                }
//                print("on appear, after animation, offset animated is \(offsetAnimated), opacity animated is \(opacityAnimated)")
            })
            .onDisappear(perform: { // reset views
                offsetAnimated = false
                opacityAnimated = false
//                print("on disappear, offset animated is \(offsetAnimated), opacity animated is \(opacityAnimated)")
            })
    }
}


extension AnyTransition {
    //    static var moveUpWardsWhileFadingIn: AnyTransition {
    //        return AnyTransition.move(edge: .bottom).combined(with: .opacity)
    //    }
    
    static var myOpacity: AnyTransition {
        return AnyTransition.modifier(
            active: OpacityModifier(opacity: 0),
            identity: OpacityModifier(opacity: 1)).animation(Animation.easeInOut(duration: 0.45))
    }
    
    static var moveUpWardsWhileFadingIn: AnyTransition {
        return AnyTransition.modifier(
            active: AnimationModifier(opacity: 0, yOffset: 100),
            identity: AnimationModifier(opacity: 1, yOffset: 0)
        ).animation(.easeInOut(duration: 0.3))
    }
    
    static var moveUpWardsWhileFadingInDelayed: AnyTransition {
        return AnyTransition.modifier(
            active: AnimationModifier(opacity: 0, yOffset: 100),
            identity: AnimationModifier(opacity: 1, yOffset: 0)
        ).animation(Animation.easeInOut(duration: 0.35).delay(0.4))
    }
    
    static var slideFromUpOpacity: AnyTransition {
        return AnyTransition.modifier(
            active: AnimationModifier(opacity: 0, yOffset: -15, xOffset: 0),
            identity: AnimationModifier(opacity: 1, yOffset: 0)
        ).animation(Animation.easeInOut(duration: 0.44).delay(0.09))
    }
    
    static var slideDownOpacity: AnyTransition {
        return AnyTransition.modifier(
            active: AnimationModifier(opacity: 0, yOffset: 15, xOffset: 0),
            identity: AnimationModifier(opacity: 1, yOffset: 0)
        ).animation(Animation.easeInOut(duration: 0.28))
    }
    
    static var slideFromLeftOpacity: AnyTransition {
        return AnyTransition.modifier(
            active: AnimationModifier(opacity: 0, yOffset: 0, xOffset: -15),
            identity: AnimationModifier(opacity: 1, yOffset: 0)
        ).animation(Animation.easeInOut(duration: 0.44).delay(0.09))
    }
    
    static var slideRightOpacity: AnyTransition {
        return AnyTransition.modifier(
            active: AnimationModifier(opacity: 0, yOffset: 0, xOffset: 15),
            identity: AnimationModifier(opacity: 1, yOffset: 0)
        ).animation(Animation.easeInOut(duration: 0.28))
    }
    
    static var slideFromRightOpacity: AnyTransition {
        return AnyTransition.modifier(
            active: AnimationModifier(opacity: 0, yOffset: 0, xOffset: 15),
            identity: AnimationModifier(opacity: 1, yOffset: 0)
        ).animation(Animation.easeInOut(duration: 0.44).delay(0.09))
    }
    
    static var slideLeftOpacity: AnyTransition {
        return AnyTransition.modifier(
            active: AnimationModifier(opacity: 0, yOffset: 0, xOffset: -15),
            identity: AnimationModifier(opacity: 1, yOffset: 0)
        ).animation(Animation.easeInOut(duration: 0.28))
    }
    
    static var textTransitionVert = AnyTransition.asymmetric(insertion: .slideFromUpOpacity, removal: .slideDownOpacity)
    
    static var textTransitionRight = AnyTransition.asymmetric(insertion: .slideFromLeftOpacity, removal: .slideRightOpacity)
    
    static var textTransitionLeft = AnyTransition.asymmetric(insertion: .slideFromRightOpacity, removal: .slideLeftOpacity)
    
    static var moveUpWards: AnyTransition {
        return AnyTransition.modifier(
            active: OffsetModifier(offset: 200),
            identity: OffsetModifier(offset: 0)
        ).animation(Animation.easeInOut(duration: 2.35))
    }
    
    static var saturate: AnyTransition {
        return AnyTransition.modifier(active: SaturationModifier(saturation: 0), identity: SaturationModifier(saturation: 0.5)).animation(Animation.easeInOut(duration: 1.50))
    }
    
    static var rotate: AnyTransition {
        return AnyTransition.modifier(active: AnimationModifier(rotation: 0), identity: AnimationModifier(rotation: 720)).animation(Animation.easeOut(duration: 1.50))
    }
    
    
    struct OpacityModifier: ViewModifier {
        let opacity: Double
        func body(content: Content) -> some View {
            content.opacity(opacity)
        }
    }
    
    struct AnimationModifier: ViewModifier {
        internal init(opacity: Double = 1, yOffset: CGFloat = 0, xOffset: CGFloat = 0, saturation: Double = 0, rotation: Double = 0) {
            self.opacity = opacity
            self.yOffset = yOffset
            self.xOffset = xOffset
            self.saturation = saturation
            self.rotation = rotation
        }
        let opacity: Double
        let yOffset: CGFloat
        let xOffset: CGFloat
        let saturation: Double
        let rotation: Double
        
        func body(content: Content) -> some View {
            content
                .opacity(opacity)
                .offset(x: xOffset, y: yOffset)
                .saturation(saturation)
                .rotationEffect(.degrees(rotation))
        }
    }
    
    struct OffsetModifier: ViewModifier {
        let offset: CGFloat
        func body(content: Content) -> some View {
            content
                .offset(x: 0, y: offset)
        }
    }
    
    struct SaturationModifier: ViewModifier {
        let saturation: Double
        func body(content: Content) -> some View {
            content
                .saturation(saturation)
        }
    }
}


extension View {
    
    func animateForever(using animation: Animation = Animation.easeInOut(duration: 1), autoreverses: Bool = false, _ action: @escaping () -> Void) -> some View {
        let repeated = animation.repeatForever(autoreverses: autoreverses)
        
        return onAppear {
            withAnimation(repeated) {
                action()
            }
        }
    }
    
    
    
    
    
    
    //    func twinkle(using animation: Animation = Animation.easeInOut(duration: 1), autoreverses: Bool = false, _ action: @escaping () -> Void) -> some View {
    //        let repeated = animation.repeatForever(autoreverses: autoreverses)
    //
    //        return onAppear {
    //            withAnimation(repeated) {
    //                action()
    //            }
    //        }
    //    }
    
}
