//
//  StringExtensionsTest.swift
//  SNPUtilities_Example
//
//  Created by Behdad Keynejad on 5/2/1397 AP.
//  Copyright © 1397 Snapp. All rights reserved.
//

import XCTest
@testable import SNPUtilities
import Foundation

class StringExtensionsTests: XCTestCase {
    func testPersian() {
        let locale = Locale(identifier: "fa_IR")
        XCTAssertEqual("1234567890".convertedDigitsFromEnglish(to: locale), "۱۲۳۴۵۶۷۸۹۰")
        var string = "1234567890"
        string.convertDigitsFromEnglish(to: locale)
        XCTAssertEqual(string, "۱۲۳۴۵۶۷۸۹۰")
        XCTAssertEqual("aText".commaSeparated(length: 0), "aText")
        XCTAssertEqual("aText".commaSeparated(length: 1), "a,T,e,x,t")
        XCTAssertEqual("aTextToTest".commaSeparated(length: 2), "aT,ex,tT,oT,es,t")
        XCTAssertEqual("EdgeToTest".commaSeparated(length: 2), "Ed,ge,To,Te,st")
        string = "aTextToTest"
        string.commaSeparate(length: 2)
        XCTAssertEqual(string, "aT,ex,tT,oT,es,t")
        XCTAssertEqual("123456".convertedToPrice(for: locale), "۱۲۳,۴۵۶")
        XCTAssertEqual("۰۹۱۹۰۱۶۳۲۸۶".convertedDigitsToEnglish(), "09190163286")
        string = "۰۹۱۹۰۱۶۳۲۸۶"
        string.convertDigitsToEnglish()
        XCTAssertEqual(string, "09190163286")
        //In case of problem call me ↑
    }
    
    func testUTF8Init() {
        let data = Data(base64Encoded: "c25hcHAgcm9ja3M=")!
        XCTAssertEqual(String(utf8Data: data), "snapp rocks")
    }
}
