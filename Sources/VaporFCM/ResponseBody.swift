import Foundation
import Result

public struct ResponseBody: Decodable {
    public let multicastId: Int
    public let success: Int
    public let failure: Int
    public let canonicalIds: Int
    private let rawResults: [RawResult]
    public var results: [Result<String, FCMError>] { return rawResults.lazy.map { $0.result } }
    private enum CodingKeys: String, CodingKey {
        case
        multicastId = "multicast_id",
        success,
        failure,
        canonicalIds = "canonical_ids",
        rawResults = "results"
    }
}


struct RawResult: Decodable {
    let messageId: String?
    let error: String?
    private enum CodingKeys: String, CodingKey {
        case
        messageId = "message_id",
        error
    }

    var result: Result<String, FCMError> {
        if let messageId = messageId {
            return .success(messageId)
        }
        if let error = error, let fcmError = FCMError(rawValue: error) {
            return .failure(fcmError)
        }
        fatalError("Unknown error(messageId: \(String(describing: messageId)), error: \(String(describing: error))")
    }
}

