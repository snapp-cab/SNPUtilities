//
//  String.swift
//  Pods-SNPUtilities_Example
//
//  Created by Behdad Keynejad on 5/2/1397 AP.
//

import Foundation

extension String {
    public func convertedDigitsFromEnglish(to locale: Locale) -> String {
        let formatter = NumberFormatter()
        formatter.locale = locale
        var formatted = ""
        for char in self {
            if let num = Int("\(char)") {
                formatted.append(formatter.string(for: num)!)
            } else {
                formatted.append(char)
            }
        }
        return formatted
    }
    
    public mutating func convertDigitsFromEnglish(to locale: Locale) {
        self = self.convertedDigitsFromEnglish(to: locale)
    }
    
    public func convertedDigitsToEnglish() -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_US")
        var formatted = ""
        for char in self {
            if let num = formatter.number(from: "\(char)") {
                formatted.append("\(num)")
            } else {
                formatted.append(char)
            }
        }
        return formatted
    }
    
    public mutating func convertDigitsToEnglish() {
        self = self.convertedDigitsToEnglish()
    }
    
    public func commaSeparated(length: Int) -> String {
        if length == 0 {
            return self
        }
        var holder: String = ""
        var start = self.startIndex
        while start < self.endIndex {
            let end = self.index(start, offsetBy: length, limitedBy: self.endIndex) ?? self.endIndex
            holder.append(String(self[start..<end]))
            start = end
            if end != self.endIndex {
                holder.append(",")
            }
        }
        return holder
    }
    
    public mutating func commaSeparate(length: Int) {
        self = self.commaSeparated(length: length)
    }
    
    public func convertedToPrice(for local:Locale) -> String {
        return String(String(self.convertedDigitsFromEnglish(to: local).reversed()).commaSeparated(length: 3).reversed())
    }
    
    public mutating func convertToPrice(for local: Locale) {
        self = self.convertedToPrice(for: local)
    }
    
    /**
     A shortcut method for printing HTTP response bodies in NSURLSessionDataTask
     - Parameter utf8Data: Data encoded in UTF8 format
     */
    public init?(utf8Data: Data) {
        self.init(data: utf8Data, encoding: .utf8)
    }
}
