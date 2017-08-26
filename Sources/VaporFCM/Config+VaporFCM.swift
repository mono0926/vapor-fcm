import Foundation
import Vapor

extension FCMSender: ConfigInitializable {
    public init(config: Config) throws {
        guard let fcm = config["fcm"] else {
            throw ConfigError.missingFile("fcm")
        }
        guard let key = fcm["key"]?.string else {
            throw ConfigError.missing(key: ["key"], file: "fcm", desiredType: String.self)
        }
        self = FCMSender(key: key,
                       client: try config.resolveClient(),
                       logger: try config.resolveLog())
    }
}

extension Config {
    public func resolveFCM() throws -> FCM {
        return try customResolve(
            unique: "fcm",
            file: "fcm",
            keyPath: ["key"],
            as: FCM.self,
            default: FCMSender.init
        )
    }
}

