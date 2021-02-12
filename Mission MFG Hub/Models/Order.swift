//
//  Order.swift
//  Mission MFG Hub
//
//  Created by Jacob Sax on 2/10/21.
//

import SwiftUI

class Order {
    init(customerName: String, poNum: String, termsString: String, terms: Terms = .invalid, dateString: String, dueDateString: String = "Enter Date", orderTotal: Float, orderNotes: String, items: [Item]) {
        self.customerName = customerName
        self.poNum = poNum
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
    var poNum: String
    var termsString: String
    var terms: Terms
    var dateString: String
    var date: Date?
    var dueDateString: String
    var dueDate: Date?
    var orderTotal: Float
    var orderNotes: String
    var items: [Item]
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
    dateFormatter.dateFormat = "yyyy-MM-dd"
    let date = dateFormatter.date(from:dateString)
    return date
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


var testOrder = Order(customerName: "Titan Wake", poNum: "110834", termsString: "Net 30", dateString: "2/10/21", orderTotal: 600, orderNotes: "", items: [testItem])


enum Terms: String {
    case net30 = "Net 30"
    case net15 = "Net 15"
    case dueOnReceipt = "Due On Receipt"
    case invalid = "Invalid"
}

