//
//  Step.swift
//  Mission MFG Hub
//
//  Created by Jacob Sax on 2/10/21.
//

import SwiftUI

class Step {
    init(title: String, text: [ String:String ], images: [ (Image, String) ], print: (Image, String), taskTime: (TimeDivision, Float), machine: String, program: String) {
        self.title = title
        self.text = text
        self.images = images
        self.print = print
        self.taskTime = taskTime
        //        self.taskTimeString = calculateTime(taskTime)
        self.machine = machine
        self.program = program
    }
    
    var title: String
    var text: [ String:String ]
    var images: [ (Image, String) ]
    var print: (Image, String)
    var taskTime: (TimeDivision, Float)
    @State var taskTimeString: String = "Enter Time"
    var machine: String
    var program: String
    
    func calculateTime(qty: Int) {
        let taskTime = self.taskTime
        Swift.print(taskTime)
        if taskTime.0 == .byStep {
            Swift.print("by step")
            let time = Int(taskTime.1)
            let string = "\(time) Min"
            self.taskTimeString = string
        }
        else if taskTime.0 == .byPer {
            Swift.print("by per")
            let time = taskTime.1
            let totalTime = Int(time * Float(qty))
            let string = "\(totalTime) Min"
            self.taskTimeString = string
        }
        else {
            Swift.print("default")
            self.taskTimeString = "Enter Time"
        }
    }
    //    func calculateTime(taskTime: (TimeDivision, Float), qty: Int) -> String {
    //        if taskTime.0 == .byStep {
    //            let time = Int(taskTime.1)
    //            let string = "\(time) Min"
    //            return string
    //        }
    //        else if taskTime.0 == .byPer {
    //            let time = taskTime.1
    //            let totalTime = Int(time * Float(qty))
    //            return "\(totalTime) Min"
    //        }
    //        return "Enter Time"
    //    }
}

var testStep = Step(title: "Machine Setup", text: ["Setup Instructions": "These are a set of instructions about all the ways in which you are supposed to set up this specific part. Deburr the edges of the material and place it down pushing it up to the top left of the stop. Then tighten the vise firmly.", "Warnings": "These are a number of warnings and things to watch out for when running these parts. They often do this or that bad thing, or a tool may accumulate chips, or some other thing that I can’t think of right now. But there are bad things that can happen so we’re writing this so you’ll know about what specific bad things happen when you aren’t careful"], images: [(Image("Triple Forks"), "Finished Triple Forks"), (Image("Triple Forks"), "Finished Triple Forks 2")], print: (Image("Triple Forks"), "Triple Fork Print"), taskTime: (.byStep, 30), machine: "VF3", program: "N/A")

var testStep2 = Step(title: "Operate Mill", text: ["Part Holding": "These are a set of instructions about all the ways in which you are supposed to set up this specific part. Deburr the edges of the material and place it down pushing it up to the top left of the stop. Then tighten the vise firmly.", "Warnings": "These are a number of warnings and things to watch out for when running these parts. They often do this or that bad thing, or a tool may accumulate chips, or some other thing that I can’t think of right now. But there are bad things that can happen so we’re writing this so you’ll know about what specific bad things happen when you aren’t careful"], images: [(Image("Triple Forks"), "Finished Triple Forks"), (Image("Triple Forks"), "Finished Triple Forks 2")], print: (Image("Triple Forks"), "Triple Fork Print"), taskTime: (.byPer, 4), machine: "VF3", program: "N/A")


enum TimeDivision: String {
    case byStep = "By Step"
    case byPer = "By Per"
}


