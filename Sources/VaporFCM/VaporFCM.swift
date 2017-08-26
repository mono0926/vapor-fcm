import Vapor
import Console
import Node
import Foundation

public protocol FCM {
    func send(notification: Notification,
              to registrationIds: [String],
              collapseKey: String?,
              priority: Priority?,
              contentAvailable: Bool?,
              mutableContent: Bool?,
              timeToLive: Int?,
              dryRun: Bool?) throws -> (HTTP.Response, ResponseBody)
}

public extension FCM {
    public func send(notification: Notification,
              to registrationIds: [String]) throws -> (HTTP.Response, ResponseBody) {
        return try self.send(notification: notification,
                             to: registrationIds,
                             collapseKey: nil,
                             priority: nil,
                             contentAvailable: nil,
                             mutableContent: nil,
                             timeToLive: nil,
                             dryRun: nil)
    }
}

public struct FCMSender: FCM {
    private let client: ClientFactoryProtocol
    private let key: String
    private let logger: LogProtocol

    public init(key: String,
                client: ClientFactoryProtocol = EngineClientFactory(),
                logger: LogProtocol = ConsoleLogger(Terminal(arguments: []))) {
        self.key = key
        self.client = client
        self.logger = logger
    }

    public func send(notification: Notification,
                     to registrationIds: [String],
                     collapseKey: String? = nil,
                     priority: Priority? = .immediately,
                     contentAvailable: Bool? = nil,
                     mutableContent: Bool? = nil,
                     timeToLive: Int? = nil,
                     dryRun: Bool? = nil) throws -> (HTTP.Response, ResponseBody) {
        var json = JSON()
        try json.set("registration_ids", registrationIds)
        try json.set("notification", notification)
        try json.setIfNotNil("collapse_key", collapseKey)
        try json.setIfNotNil("priority", priority?.rawValue)
        try json.setIfNotNil("content_available", contentAvailable)
        try json.setIfNotNil("mutable_content", mutableContent)
        try json.setIfNotNil("time_to_live", timeToLive)
        try json.setIfNotNil("dry_run", dryRun)
        let response = try client.post(
            "https://fcm.googleapis.com/fcm/send",
            ["Authorization": "key=\(key)",
                "Content-Type": "application/json"],
            json)
        let responseBody = try JSONDecoder().decode(ResponseBody.self, from: Data(bytes: response.body.bytes ?? []))
        logger.debug("response: \(response)")
        return (response, responseBody)
    }
}

