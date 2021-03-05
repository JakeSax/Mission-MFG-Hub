//
//  Step.swift
//  Mission MFG Hub
//
//  Created by Jacob Sax on 2/10/21.
//

import SwiftUI

class Step: ObservableObject {
    init(title: String, text: [ String:String ], images: [ (Image, String) ], print: (Image, String), taskTimeTuple: (String, String), machine: String, program: String) {
        self.title = title
        self.text = text
        self.images = images
        self.print = print
        self.taskTimeTuple = taskTimeTuple
        self.machine = machine
        self.program = program
    }
    
    @State var title: String // title of step
    @Published var text: [ String:String ] // [ Header : Body ]
    @State var images: [ (Image, String) ] // [ (Image: Desc) ]
    @State var print: (Image, String) // (Image: Desc)
    @State var taskTimeTuple: (String, String) // ("By Step", "30") or ("By Per", "4")
    lazy var taskTime: (TimeDivision, Float) = convertTimeStrings(timeTuple: taskTimeTuple)
    @State var timeFormat: TimeFormat = .minutes
    @State var machine: String
    @State var program: String
    
    // converts formatted tuple into string
    func calculateTime(qty: Int) -> String {
        let taskTime = self.taskTime
        if taskTime.0 == .byStep {
            let time = Int(taskTime.1)
            let string = "\(time) \(self.timeFormat.rawValue)"
            return string
        }
        else if taskTime.0 == .byPer {
            let time = taskTime.1
            let totalTime = Int(time * Float(qty))
            return "\(totalTime) \(self.timeFormat.rawValue)"
        }
        return "Enter Time"
    }
    
    // converts incoming strings of data into formatted tuple
    fileprivate func convertTimeStrings( timeTuple: (String, String) ) -> (TimeDivision, Float) {
        let divisionString = timeTuple.0
        let timeString = timeTuple.1
        var tuple: (TimeDivision, Float) = (.empty, 0)
        if divisionString.contains("By Per") {
            let division: TimeDivision = .byPer
            if let time = Float(timeString) {
                tuple = (division, time)
            }
        }
        else if divisionString.contains("By Step") {
            let division: TimeDivision = .byStep
            if let time = Float(timeString) {
                tuple = (division, time)
            }
        }
        return tuple
    }
    // converts hours to minutes, and visa versa
    func convertTime(str: String) -> String {
        let array = str.split(separator: " ")
        
        if let time = Float(array[0]) {
            if array[1] == TimeFormat.minutes.rawValue {
                let float: Float = Float(time) / 60
                return ("\(float) \(TimeFormat.hours.rawValue)")
            }
            if array[1] == TimeFormat.hours.rawValue {
                let float: Float = Float(time) * 60
                return ("\(Int(float)) \(TimeFormat.minutes.rawValue)")
            } }
        return "Enter Time"
    }
    
}
var testTaskTimeTuple: (String, String) = ("By Step", "30")
var testTaskTimeTuple2: (String, String) = ("By Per", "4")

var testStep = Step(title: "Machine Setup", text: ["Setup Instructions": "These are a set of instructions about all the ways in which you are supposed to set up this specific part. Deburr the edges of the material and place it down pushing it up to the top left of the stop. Then tighten the vise firmly.", "Warnings": "These are a number of warnings and things to watch out for when running these parts. They often do this or that bad thing, or a tool may accumulate chips, or some other thing that I can’t think of right now. But there are bad things that can happen so we’re writing this so you’ll know about what specific bad things happen when you aren’t careful"], images: [(Image("Triple Forks"), "Finished Triple Forks"), (Image("Triple Forks"), "Finished Triple Forks 2")], print: (Image("Triple Forks"), "Triple Fork Print"), taskTimeTuple: testTaskTimeTuple,  machine: "VF3", program: "N/A")

var testStep2 = Step(title: "Operate Mill", text: ["Part Holding": "First clear the vise of any loose chips or coolant. Ensure that the back side of the jaws are clean as well. Once you have deburred the material, place it deburred side down and push it up against the back of the jaw and all the way to left against the stop. Push the material down and to the left corner away from you as you tighten the jaws. Tighten firmly.", "Tips & Warnings": "But hey watch out for some things that I'm about to explain right now. I'm gonna explain a number of things so watch out or else you might get hurt or hurt the machine or ruin the part. Okay, I'm gonna explain it now.These are a number of warnings and things to watch out for when running these parts. They often do this or that bad thing, or a tool may accumulate chips, or some other thing that I can’t think of right now. But there are bad things that can happen so we’re writing this so you’ll know about what specific bad things happen when you aren’t careful"], images: [(Image("Triple Forks"), "Finished Triple Forks"), (Image("Triple Forks"), "Finished Triple Forks 2")], print: (Image("Triple Forks"), "Triple Fork Print"), taskTimeTuple: testTaskTimeTuple2, machine: "VF3", program: "1043")


enum TimeDivision: String {
    case byStep = "By Step"
    case byPer = "By Per"
    case empty = "Empty"
}

enum TimeFormat: String {
    case minutes = "MIN"
    case hours = "HR"
}

struct StepText {
//    let id = UUID()
    @State var header: String = "Add Header"
    @State var body: String = "Add text here…"
    
}
