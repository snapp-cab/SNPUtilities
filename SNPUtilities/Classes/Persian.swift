//
//  Persian.swift
//  Pods-SNPUtilities_Example
//
//  Created by farhad jebelli on 7/2/18.
//

import Foundation

extension UInt16 {
    public var toPersian: UInt16 {
        return self - "0".utf16.first! + "۰".utf16.first!
    }
}
extension Character {
    public var toPersian: Character {
        if !("0"..."9" ~= self){
            return self
        }
        return Character(Unicode.Scalar((self.unicodeScalars.first?.utf16.first)!.toPersian)!)
    }
}

extension String {
    public func convertDigitsToPersian() -> String {
            return String(self.map({$0.toPersian}))
    }
    public mutating func convertedDigitsToPersian() {
        self = self.convertDigitsToPersian()
    }
    
    public func commaSeparate(length: Int) -> String {
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
    
    public mutating func commaSeparated(length: Int) {
        self = self.commaSeparate(length: length)
    }
    
    public func convertPersianPrice() -> String {
        return String(String(self.convertDigitsToPersian().reversed()).commaSeparate(length: 3).reversed())
    }
    public mutating func convertedPersianPrice() {
        self = self.convertPersianPrice()
    }

}

