import XCTest
import VaporFCM

private let key = "YOUR_VALID_FCM_KEY"
private let token = "YOUR_VALID_FCM_TOKEN"

class vapor_fcmTests: XCTestCase {
    func testSend() throws {
        let fcm = FCMSender(key: key)
        let notification = VaporFCM.Notification(title: "title",
                                                 body: "body",
                                                 sound: "Default",
                                                 badge: 2,
                                                 clickAction: "click_action",
                                                 bodyLocKey: "body_loc_key",
                                                 bodyLocArgs: ["body_loc_args"],
                                                 titleLocKey: "title_loc_key",
                                                 titleLocArgs: ["title_loc_args"],
                                                 custom: ["foo": "bar"])
        let (response, body) = try fcm.send(notification: notification,
                                            to: [token],
                                            collapseKey: nil,
                                            priority: .immediately,
                                            contentAvailable: true,
                                            mutableContent: false,
                                            timeToLive: 60,
                                            dryRun: false)
        print("response: \(response)")
        print("body: \(body)")
        body.results.forEach { print("result: \($0)") }
        XCTAssertEqual(body.results.count, 1)
        XCTAssertNil(body.results.first!.error)
    }

    func testSend_fail() throws {
        let fcm = FCMSender(key: key)
        let notification = VaporFCM.Notification(title: "title")
        let (response, body) = try fcm.send(notification: notification,
                                            to: ["invalid_token"])
        print("response: \(response)")
        print("body: \(body)")
        body.results.forEach { print("result: \($0)") }
        XCTAssertEqual(body.results.count, 1)
        XCTAssertEqual(body.results.first?.error, .InvalidRegistration)
    }
    static var allTests = [
        ("testSend", testSend),
        ("testSend_fail", testSend_fail),
        ]
}

