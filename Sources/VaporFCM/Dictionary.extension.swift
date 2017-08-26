extension Dictionary {
    public mutating func merge(_ dictionary: Dictionary) {
        dictionary.forEach { updateValue($0.value, forKey: $0.key) }
    }

    public func merged(_ dictionary: Dictionary) -> Dictionary {
        var dict = self
        dict.merge(dictionary)
        return dict
    }
}