//
//  NavHeader.Swift
//  Mission MFG Hub
//
//  Created by Jacob Sax on 2/8/21.
//


import SwiftUI

struct NavHeader: View {
    
    var title: String
    var buttons: [AnyView] = []
    var backButtonAction: () -> Void
    var onAppearAction: () -> Void = { print("Header is here!") }
    var showBackButton = true
    var backButtonType: BackButton.BackButtonType = .leftArrow
    
    
    var body: some View {
        VStack(alignment: .center) {
            
            HStack(alignment: .center) {
                if showBackButton {
                    BackButton(backButtonAction: self.backButtonAction, backButtonType: self.backButtonType )
                }
                
                Text(title)
                    .modifier(H3())
                    .lineLimit(1)
                    .padding(.leading, 12)
                
                Spacer(minLength: 12)
                
                ForEach(0..<buttons.count) { button in
                    self.buttons[button].padding(.trailing, 2)
                }
            }
            
            Line(width: paddedScreenWidth, color: .black)
                .padding(.top, -4)
        }
        .padding(EdgeInsets(top: 16, leading: 16, bottom: 8, trailing: 16))
        .edgesIgnoringSafeArea(.all)
        .modifier(FadeInOnAppear(dampingCoefficient: 1.3))
        .onAppear(perform: {
            onAppearAction()
        })
        
        
    }
}


struct NavHeader_Previews: PreviewProvider {
    static var previews: some View {
        NavHeader(title: "Chemex", buttons: [], backButtonAction: { print("go back")  }, backButtonType: .xMark)
    }
}



