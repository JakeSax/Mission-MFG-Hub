//
//  Order.swift
//  Mission MFG Hub
//
//  Created by Jacob Sax on 2/10/21.
//

import SwiftUI

class Order: ObservableObject {
    init(customerName: String, poNum: String, orderNum: String, termsString: String, terms: Terms = .invalid, dateString: String, dueDateString: String = "Enter Date", orderTotal: Float, orderNotes: String, items: [Item]) {
        self.customerName = customerName
        self.poNum = poNum
        self.orderNum = orderNum
        self.termsString = termsString
        self.terms = determineTerms(termsString)
        self.dateString = dateString
        self.date = determineDate(dateString)
        self.dueDateString = dueDateString
        self.orderTotal = orderTotal
        self.orderNotes = orderNotes
        self.items = items
    }
    
    var customerName: String
    @Published var poNum: String
    @Published var orderNum: String
    var termsString: String
    var terms: Terms
    var dateString: String
    var date: Date?
    var dueDateString: String
    var dueDate: Date?
    var orderTotal: Float
    var orderNotes: String
    @Published var items: [Item]
    
    func getDateString() -> String {
        guard let date = date
        else {
            return "Enter Date"
        }
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        let outDateString = formatter.string(from: date)
        return outDateString
    }

}

fileprivate func determineTerms(_ termsString: String) -> Terms {
    if termsString.contains("Net 30") { return .net30 }
    else if termsString.contains("Net 15") { return .net15 }
    else if termsString.contains("Due On Receipt") { return .dueOnReceipt }
    else { return .invalid }
}

fileprivate func determineDate(_ dateString: String) -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
    dateFormatter.dateFormat = "MM/dd/yyyy"  // "yyyy-MM-dd"
    let date = dateFormatter.date(from:dateString)
    return date
}

var testOrder = Order(customerName: "Titan Wake", poNum: "110834", orderNum: "TTN-110834", termsString: "Net 30", dateString: "2/10/21", orderTotal: 600, orderNotes: "", items: [testItem])
var testOrder2 = Order(customerName: "Eteros Technology", poNum: "110839", orderNum: "ETS-110839", termsString: "Net 30", dateString: "2/12/21", orderTotal: 40, orderNotes: "", items: [testItem, testItem2, testItem3])
var testOrder3 = Order(customerName: "Marquez Design", poNum: "110840", orderNum: "MQZ-110840", termsString: "Net 30", dateString: "2/11/21", orderTotal: 60, orderNotes: "", items: [testItem, testItem2])

enum Terms: String {
    case net30 = "Net 30"
    case net15 = "Net 15"
    case dueOnReceipt = "Due On Receipt"
    case invalid = "Invalid"
}



//fileprivate func determineDueDate(_ date: Date?, terms: Terms) -> Date? {
//    print("DetermineDueDate from file Order is incomplete")
//    if let safeDate = date {
////        safeDate.addTimeInterval(<#T##timeInterval: TimeInterval##TimeInterval#>)
//        // date + days from terms
//        return safeDate
//    }
//    return nil
//}
