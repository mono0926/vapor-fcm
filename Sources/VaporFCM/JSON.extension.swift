import Vapor

extension JSON {
    mutating func setUnlessNil(_ path: String, _ value: Any?) throws {
        if let value = value {
            try set(path, value)
        }
    }
}
