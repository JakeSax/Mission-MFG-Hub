//
//  ContentView.swift
//  Mission MFG Hub
//
//  Created by Jacob Sax on 2/8/21.
//

import SwiftUI

struct ItemView: View {
    var item: Item
    @State var currentStep: Int = 0
    @State var photoChoice: PhotoChoice = .steps
    @State var photoNum: Int = 0
    @State var active: Bool = true
    
    var body: some View {
        ZStack {
            white
                .onAppear(perform: { updateView() })
            HStack {
                
                // MARK: - Part Info
                VStack(alignment: .leading, spacing: 0) {
                    Group {
                        Text(item.partTitle)
                            .padding()
                            .padding(.bottom, -12)
                            .H1Style()
                            .foregroundColor(black)
                            .leftAlign()
                        Line(width: 660).padding()
                    }.padding(.leading, 40)
                    
                    HStack {
                        Text(item.steps[currentStep].title)
                            .padding()
                            .H4Style()
                            .foregroundColor(gray7)
                        Spacer()
                        Line(width: 180, maxWidth: 200, color: gray3)
                        Spacer()
                        ArrowButtonPair(index: $currentStep, max: item.steps.count)
                    }.padding(EdgeInsets(top: 0, leading: 0, bottom: -8, trailing: 12))
                    
                    HStack {
                        Text("Machine: \(item.steps[currentStep].machine)")
                        Spacer()
                        Text("Time: \(item.steps[currentStep].taskTimeString)")
                        Spacer()
                        Text("Program: \(item.steps[currentStep].program)")
                    }.LabelStyle()
                    .foregroundColor(gray6)
                    .padding()
                    .padding(.bottom, -12)
                    
                    Line(width: 660, color: gray3).padding()
                    
                    ScrollView {
                        VStack(alignment: .leading, spacing: 20) {
                            Group {
                                RefreshButton(action:{ updateView() })
                                EditButton()
                            }.rightAlign()
                            .offset(x: -40, y: 28)
                            .padding(-20)
                            ForEach((item.steps[currentStep].text.keys).sorted(), id: \.self) { key in
                                Text(key)
                                    .H5Style()
                                    .foregroundColor(black)
                                Text(item.steps[currentStep].text[key]!)
                                    .BodyStyle()
                                    .foregroundColor(gray6)
                                    .padding(.bottom, 12)
                            }
                        }
                    }.padding()
                    .padding(.top, -20)
                    
                    Spacer()
                }.padding()
                
                // MARK: - Photos
                VStack{
                    ZStack {
                        if photoChoice == .print {
                            (item.steps[currentStep].print.0)
                                .resizable()
                                .scaledToFill()
                                .opacity(0.8)
                        }
                        
                        if photoChoice == .steps {
                            // Show step photo and arrow buttons
                            (item.steps[currentStep].images[photoNum].0)
                                .resizable()
                                .scaledToFill()
                            
                            VStack {
                                Spacer()
                                HStack {
                                    Spacer()
                                    ArrowButtonPair(index: $photoNum, max: item.steps[currentStep].images.count - 1)
                                }.padding(EdgeInsets(top: 0, leading: 0, bottom: 32, trailing: 40))
                            }.padding()
                        }
                        
                    }.padding()
                    .frame(width: 1080, height: 720, alignment: .center)
                    Spacer()
                }.padding()
            }
        }.frame(width: 1920, height: 1080, alignment: .center)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ItemView(item: testItem)
    }
}

enum PhotoChoice {
    case print
    case steps
}

extension ItemView {
    func updateView() {
        item.steps[currentStep].calculateTime(qty: item.qty)
    }
}
