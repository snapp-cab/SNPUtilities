//
//  SNPDecoder.swift
//  SNPUtilities_Tests
//
//  Created by farhad jebelli on 8/19/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
@testable import SNPUtilities
class SNPDecoderTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testIntArrayWithNoCodingPath() {
        do{
        let t:[Int]? = try SNPDecoder(type: Int.self, data: intArrayWithNoCodingPath!, codingPath: "").decodeArray()
        XCTAssertEqual(t!, [1,2,3,4,5])
    } catch {
            XCTFail()
            print(error.localizedDescription)
        }
    }
    
    func testEmptyArrayWithNoCodingPath() {
        do {
            let t: [String]? = try SNPDecoder(type: String.self, data: emptyArrayWithNoCodingPath!, codingPath: "").decodeArray()
            XCTAssertEqual(t!.count, 0)
            
        } catch {
            XCTFail()
            print(error.localizedDescription)
        }
    }
    func testPersonWithNoCodingPath() {
        do {
            let t: Person? = try SNPDecoder(type: Person.self, data: personWithNoCodingPath!, codingPath: "").decode()
            XCTAssertEqual(t?.age, 32)
            XCTAssertEqual(t?.name, "jalal")
            XCTAssertEqual(t?.nikeNames, ["mashti", "bombi", "dadasham"])
            
        } catch {
            XCTFail()
            print(error.localizedDescription)
        }
    }
    
    func testPersonArrayWithNoCodingPath() {
        do {
            let j: [Person]? = try SNPDecoder(type: Person.self, data: personArrayWithNoCodingPath!, codingPath: nil).decodeArray()
            let t = j?[0]
            XCTAssertEqual(j?.count, 2)
            XCTAssertEqual(t?.age, 32)
            XCTAssertEqual(t?.name, "jalal")
            XCTAssertEqual(t?.nikeNames, ["mashti", "bombi", "dadasham"])
            
        } catch {
            XCTFail()
            print(error.localizedDescription)
        }
    }
    
    
    func testPersonWithCodingPath() {
        do {
            let t: Person? = try SNPDecoder(type: Person.self, data: personWithCodingPath!, codingPath: "perssson").decode()
            XCTAssertEqual(t?.age, 32)
            XCTAssertEqual(t?.name, "jalal")
            XCTAssertEqual(t?.nikeNames, ["mashti", "bombi", "dadasham"])
            
        } catch {
            XCTFail()
            print(error.localizedDescription)
        }
    }
    
    func testPersonArrayWithCodingPath() {
        do {
            let j: [Person]? = try SNPDecoder(type: Person.self, data: personArrayWithCodingPath!, codingPath: "persssons").decodeArray()
            let t = j?[0]
            XCTAssertEqual(j?.count, 2)
            XCTAssertEqual(t?.age, 32)
            XCTAssertEqual(t?.name, "jalal")
            XCTAssertEqual(t?.nikeNames, ["mashti", "bombi", "dadasham"])
            
        } catch {
            XCTFail()
            print(error.localizedDescription)
        }
    }
    
    
    
    
    func testIntArrayWithCodingPath() {
        do{
            let t:[Int]? = try SNPDecoder(type: Int.self, data: intArrayWithCodingPath!, codingPath: "index").decodeArray()
            XCTAssertEqual(t!, [1,2,3,4,5])
        } catch {
            XCTFail()
            print(error.localizedDescription)
        }
    }
    
    func testIntArrayWithCodingPathToSingleeElement() {
        do {
            let t: String? = try SNPDecoder(type: String.self, data: mixedArrayWithCodingPath!, codingPath: "index.0").decode()
            XCTAssertEqual(t!, "1")
            let j: Int? = try SNPDecoder(type: Int.self, data: mixedArrayWithCodingPath!, codingPath: "index.1").decode()
            XCTAssertEqual(j!, 2)
        } catch {
            XCTFail()
            print(error.localizedDescription)
        }
    }
    
    func testEmptyArrayWithOutCodingPath() {
        do {
            let t: [String]? = try SNPDecoder(type: String.self, data: emptyArrayWithCodingPath!, codingPath: "index").decodeArray()
            XCTAssertEqual(t!.count, 0)
            
        } catch {
            XCTFail()
            print(error.localizedDescription)
        }
    }
    
    func testNestedArray() {
        do {
            let t: Int? = try SNPDecoder(type: Int.self, data: nestedArray!, codingPath: "index.0.1").decode()
            XCTAssertEqual(t, 2)
            
        } catch {
            XCTFail()
            print(error.localizedDescription)
        }
    }
    
    func testNestedNestedArray() {
        do {
            let t: [Int]? = try SNPDecoder(type: Int.self, data: nestedNestedArray!, codingPath: "index.0.0.0").decodeArray()
            XCTAssertEqual(t?.count, 1)
            XCTAssertEqual(t?[0], 1)
            
        } catch {
            XCTFail(error.localizedDescription)

        }
    }
    
    func testEmpty() {
        do {
            let person: Person? = try SNPDecoder(type: Person.self, data: empty!, codingPath: "data").decode()
            XCTAssertNotNil(person)
            XCTAssertNil(person?.age)
            
        } catch {
            XCTFail(error.localizedDescription)
            
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

struct Person: Codable {
    var name: String?
    var age: Int?
    var nikeNames: [String]?
    
    enum CodingKeys: String, CodingKey {
        case name
        case age
        case nikeNames = "nike_names"
    }
    
}




let intArrayWithCodingPath = """
{"index": [1,2,3,4,5]}
""".data(using: .utf8)
let mixedArrayWithCodingPath = """
{"index": ["1",2,true,4,5]}
""".data(using: .utf8)
let emptyArrayWithCodingPath = """
{"index": []}
""".data(using: .utf8)
let personWithCodingPath = """
{"perssson": {"name": "jalal", "age": 32, "nike_names": ["mashti", "bombi", "dadasham"]}}
""".data(using: .utf8)
let personArrayWithCodingPath = """
{"persssons":[{"name": "jalal", "age": 32, "nike_names": ["mashti", "bombi", "dadasham"]},{"name": "jalal", "age": 32, "nike_names": ["mashti", "bombi", "dadasham"]}]}
""".data(using: .utf8)



let personWithNoCodingPath = """
{"name": "jalal", "age": 32, "nike_names": ["mashti", "bombi", "dadasham"]}
""".data(using: .utf8)
let personArrayWithNoCodingPath = """
[{"name": "jalal", "age": 32, "nike_names": ["mashti", "bombi", "dadasham"]},{"name": "jalal", "age": 32, "nike_names": ["mashti", "bombi", "dadasham"]}]
""".data(using: .utf8)
let emptyArrayWithNoCodingPath = """
[]
""".data(using: .utf8)
let intArrayWithNoCodingPath = """
[1,2,3,4,5]
""".data(using: .utf8)



let nestedArray = """
{"index": [[1,2,3],2,3,4,5]}
""".data(using: .utf8)

let nestedNestedArray = """
{"index": [[[[1]],2,3],2,3,4,5]}
""".data(using: .utf8)

let empty = """
{"data":{"message":"ride cancelled successfully"},"status":200}
""".data(using: .utf8)
