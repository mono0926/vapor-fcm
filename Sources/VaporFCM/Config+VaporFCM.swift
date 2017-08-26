import Foundation
import Vapor

extension FCMSender: ConfigInitializable {
    public init(config: Config) throws {
        guard let firebase = config["firebase"] else {
            throw ConfigError.missingFile("firebase")
        }
        guard let key = firebase["fcm-key"]?.string else {
            throw ConfigError.missing(key: ["fcm-key"], file: "firebase", desiredType: String.self)
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

