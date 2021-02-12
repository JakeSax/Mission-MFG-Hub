//
//  HomeHeaderView.swift
//  Mission MFG Hub
//
//  Created by Jacob Sax on 2/8/21.
//



import SwiftUI

struct HomeHeaderView: View {
    @State var greeting: (String, String) = ("Good Morning", "cloud.sun")
    @State var rotation: Angle = Angle.degrees(-2)
    @State var scale: CGFloat = 1
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack{
                Spacer()
//                LogButton().padding(.trailing, -16)
            }.padding(.bottom, -4)
            HStack {
                Text(greeting.0)
                    .modifier(H1())
                    .lineLimit(1)
                    .foregroundColor(offBlack)
                    .offset(x: -2, y: 0)
            }.onAppear( perform: {
                self.greeting = self.setGreeting()
            })
            Line(width: paddedScreenWidth, height: 1.2, color: gray4)
        }
        .padding(EdgeInsets(top: 24, leading: 16, bottom: 16, trailing: 16))
    }
}

extension HomeHeaderView {
    func setGreeting() -> (title: String, weathericonString: String) {
        // just sets the title to say good morning based on time
        let currentTime = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "H" // set dateFormat to Hour
        var title = "Hello There"
        var weatherIconString = "cloud.sun"
        
        let timeString = formatter.string(from: currentTime)
        if let timeInt = Int(timeString) {
            if (5...11).contains(timeInt) {
                title = "Good Morning"
            } else if (11...16).contains(timeInt) {
                title = "Good Afternoon"
            } else if (16...20).contains(timeInt) {
                title = "Good Evening"
                weatherIconString = "cloud.moon"
            } else {
                title = "Good Night"
                weatherIconString = "cloud.moon"
            }
        }
        return (title, weatherIconString)
    }
}
//
//struct LogButton: View {
//    @State var isShowingLog = false
//    var body: some View {
//        Button(action: {
//            self.isShowingLog.toggle()
//        },
//        label: {
//            Image(systemName: "line.horizontal.3.decrease.circle.fill")
//                .font(.system(size: 28, weight: .regular, design: .default))
//                .foregroundColor(offBlack)
//                .padding(.trailing, 20)
//        }).sheet(isPresented: $isShowingLog, content: {
//            LogPage()
//        })
//    }
//}
