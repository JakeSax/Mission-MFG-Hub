//
//  Item.swift
//  Mission MFG Hub
//
//  Created by Jacob Sax on 2/10/21.
//

import SwiftUI

class Item {
    init(partNum : String, partTitle : String, partDesc : String, qty : Int, pricePer : Float, priceTotal : Float, weightPer : Float, steps : [Step]) {
        self.partNum = partNum
        self.partTitle = partTitle
        self.partDesc = partDesc
        self.qty = qty
        self.pricePer = pricePer
        self.priceTotal = priceTotal
        self.weightPer = weightPer
        self.steps = steps
    }
    
    var partNum : String
    var partTitle : String
    var partDesc : String
    var qty : Int
    var pricePer : Float
    var priceTotal : Float
    var weightPer : Float
    var steps : [Step]
    @State var currentStep : Int = 0
}

var testItem = Item(partNum: "TTN-FK-TRP", partTitle: "Triple Fork", partDesc: "Triple Fork for wakeboard racks", qty: 120, pricePer: 130.00, priceTotal: 15600.00, weightPer: 1.1, steps: [testStep, testStep2])
var testItem2 = Item(partNum: "TTN-FK-TRP", partTitle: "Double Fork", partDesc: "Double Fork for wakeboard racks", qty: 120, pricePer: 130.00, priceTotal: 15600.00, weightPer: 1.1, steps: [testStep, testStep2])
var testItem3 = Item(partNum: "TTN-FK-TRP", partTitle: "Combo Fork", partDesc: "Combo Fork for wakeboard racks", qty: 120, pricePer: 130.00, priceTotal: 15600.00, weightPer: 1.1, steps: [testStep, testStep2])
