//
//  SNPErrorTests.swift
//  SNPUtilities_Example
//
//  Created by Behdad Keynejad on 5/2/1397 AP.
//  Copyright © 1397 Snapp. All rights reserved.
//

import XCTest
@testable import SNPUtilities
import Foundation

class SNPErrorTests: XCTestCase {
    private func generateSNPError(domain: String, code: Int, message: String) -> SNPError {
        return SNPError(domain: domain, code: code, message: message)
    }
    
    func testSNPError() {
        let snpError = generateSNPError(domain: SNPErrorDomain.generic, code: 999, message: SNPErrorDomain.generic)
        expectedString = SNPErrorDomain.generic
        XCTAssertNotNil(expectedString)
        XCTAssertEqual(expectedString, snpError.message)
        XCTAssertEqual(999, snpError.code)
        XCTAssertEqual(SNPErrorDomain.generic, snpError.domain)
    }
}
