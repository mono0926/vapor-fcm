import Foundation
import Vapor

extension FCMSender: ConfigInitializable {
    public init(config: Config) throws {
        guard let firebase = config["firebase"] else {
            throw ConfigError.missingFile("firebase")
        }
        guard let key = firebase["fcmKey"]?.string else {
            throw ConfigError.missing(key: ["fcmKey"], file: "firebase", desiredType: String.self)
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
            file: "firebase",
            keyPath: ["fcm"],
            as: FCM.self,
            default: FCMSender.init
        )
    }
}

