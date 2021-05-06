//
//  Utilities.swift
//  Mission MFG Hub
//
//  Created by Jacob Sax on 2/8/21.
//


import SwiftUI

// MARK: - Various Functions

func getPlist(withName name: String = "User") -> [String]?
{
    if let path = Bundle.main.path(forResource: name, ofType: "plist"),
        let xml = FileManager.default.contents(atPath: path)
    {
        return (try? PropertyListSerialization.propertyList(from: xml, options: .mutableContainersAndLeaves, format: nil)) as? [String]
    }
    return nil
}

func bigPrint(_ string: String) {
    print("\n\n\n\n\n\(string)\n\n\n\n\n")
}

extension Float {
    func stringToTenth() -> String {
        return String(format: "%.1f", self)
    }
    func stringToWhole() -> String {
        return String(format: "%1.f", self)
    }
}


// MARK: - Ease of use Enums


enum Brightness {
    case lighten
    case darken
}
