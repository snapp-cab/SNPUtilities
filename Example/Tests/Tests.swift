import XCTest
@testable import SNPUtilities
import Foundation

// MARK: - General subjects
public enum FileExistence: Equatable {
    case none
    case file
    case directory
}

public func ==(lhs: FileExistence, rhs: FileExistence) -> Bool {
    
    switch (lhs, rhs) {
    case (.none, .none),
         (.file, .file),
         (.directory, .directory):
        return true
        
    default: return false
    }
}

extension FileManager {
    public func existence(atUrl url: URL) -> FileExistence {
        
        var isDirectory: ObjCBool = false
        let exists = self.fileExists(atPath: url.path, isDirectory: &isDirectory)
        
        switch (exists, isDirectory.boolValue) {
        case (false, _): return .none
        case (true, false): return .file
        case (true, true): return .directory
        }
    }
}

var expectedString: String!

class Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK: - Test Utililties methods
    func createTempDirectory() -> URL {
        
        let fileName = "filemanagertest-temp-dir.\(NSUUID().uuidString)"
        let fileUrl = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName)
        
        try! FileManager.default.createDirectory(at: fileUrl, withIntermediateDirectories: false, attributes: nil)
        
        return fileUrl
    }
    
    func createTempFileURL() -> URL {
        
        let fileName = "filemanagertest-temp.\(NSUUID().uuidString)"
        let fileURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName)
        
        return fileURL
    }
    
    func testClearTempDirectoryWasSuccessful() {
        class MockUtilities: Utilities {
        }
        
        //generate temp directory and test of existance
        let url = createTempDirectory()
        XCTAssertEqual(FileManager.default.existence(atUrl: url), FileExistence.directory)
        
        //now delete the directory and test that
        MockUtilities.clearTempDirectory()
        XCTAssertEqual(FileManager.default.existence(atUrl: url), FileExistence.none)
    }
    
    func testSearchAndDeleteFilesInDocumentsFolderWasSuccessful() {
        class MockUtilities: Utilities {
            
            override class func searchAndDeleteFilesInDocumentsFolder(ext: String) {
                let fileManager = FileManager.default
                let tempURL = NSURL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
                do {
                    let tempUrls = try  fileManager.contentsOfDirectory(at: tempURL as URL, includingPropertiesForKeys: nil, options: FileManager.DirectoryEnumerationOptions())
                    for file in tempUrls {
                        try fileManager.removeItem(at: file)
                    }
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
        }
        
        //generate temp file and test of existance
        let url = createTempFileURL()
        guard let _ = try? "some content".write(to: url, atomically: false, encoding: .utf8)
            else { XCTFail("writing failed"); return }
        XCTAssertEqual(FileManager.default.existence(atUrl: url), FileExistence.file)
        
        //now delete the file and test that
        MockUtilities.searchAndDeleteFilesInDocumentsFolder(ext: url.pathExtension)
        XCTAssertEqual(FileManager.default.existence(atUrl: url), FileExistence.none)
    }
    
    // MARK: - Test SNPError
    
    private func generateSNPAuthenticationError(type: SNPAuthenticationError) -> SNPError {
        return SNPError(domain: SNPErrorDomain.authentication, code: type.code, message: type.message)
    }
    
    private func generateSNPError(domain: String, code: Int, message: String) -> SNPError {
        //return SNPError(domain: SNPErrorDomain.authentication, code: type.code, message: type.message)
        return SNPError(domain: domain, code: code, message: message)
    }
    
    func testSNPError() {
        let snpError = generateSNPError(domain: SNPErrorDomain.authentication, code: 999, message: SNPErrorDomain.generic)
        expectedString = SNPErrorDomain.generic
        XCTAssertNotNil(expectedString)
        XCTAssertEqual(expectedString, snpError.message)
        XCTAssertEqual(999, snpError.code)
        XCTAssertEqual(SNPErrorDomain.authentication, snpError.domain)
    }
    
    func testSNPAuthenticationError() {
        let snpError = generateSNPAuthenticationError(type: SNPAuthenticationError.emptyPassword)
        expectedString = "Please enter your password"
        XCTAssertNotNil(expectedString)
        XCTAssertEqual(expectedString, snpError.message)
        XCTAssertEqual(3, snpError.code)
        XCTAssertEqual(SNPErrorDomain.authentication, snpError.domain)
    }
}