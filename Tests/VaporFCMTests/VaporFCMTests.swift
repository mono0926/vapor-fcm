import XCTest
@testable import vapor_fcm

class vapor_fcmTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(vapor_fcm().text, "Hello, World!")
    }


    static var allTests = [
        ("testExample", testExample),
    ]
}
