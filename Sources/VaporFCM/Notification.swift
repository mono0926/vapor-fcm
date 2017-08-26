import Vapor

/// https://firebase.google.com/docs/cloud-messaging/http-server-ref#notification-payload-support
public struct Notification {

    public let title: String?
    public let body: String?
    public let sound: String?
    public let badge: Int?
    public let clickAction: String?
    public let bodyLocKey: String?
    public let bodyLocArgs: [String]?
    public let titleLocKey: String?
    public let titleLocArgs: [String]?
    public let custom: [String: Any]

    public init(title: String? = nil,
                body: String? = nil,
                sound: String? = nil,
                badge: Int? = nil,
                clickAction: String? = nil,
                bodyLocKey: String? = nil,
                bodyLocArgs: [String]? = nil,
                titleLocKey: String? = nil,
                titleLocArgs: [String]? = nil,
                custom: [String: Any] = [:]) {
        self.title = title
        self.body = body
        self.sound = sound
        self.badge = badge
        self.clickAction = clickAction
        self.bodyLocKey = bodyLocKey
        self.bodyLocArgs = bodyLocArgs
        self.titleLocKey = titleLocKey
        self.titleLocArgs = titleLocArgs
        self.custom = custom
    }
}

extension Notification: NodeRepresentable {
    public func makeNode(in context: Context?) throws -> Node {
        let aps: [String: Any?] =  ["title": title,
                     "body": body,
                     "sound": sound,
                     "badge": badge,
                     "click_action": clickAction,
                     "body_loc_key": bodyLocKey,
                     "body_loc_args": bodyLocArgs,
                     "title_loc_key": titleLocKey,
                     "title_loc_args": titleLocArgs]
        let payload = aps.filter { $0.value != nil }.mapValues { $0! }.merged(custom)
        return try Node(node: payload)
    }
}
