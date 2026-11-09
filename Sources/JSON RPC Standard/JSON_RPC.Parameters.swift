public import RFC_8259

extension JSON_RPC {
    /// The `params` of a request: an array of values by position, or an object of values by name.
    public enum Parameters: Sendable, Hashable {
        case byPosition(RFC_8259.Array)
        case byName(RFC_8259.Object)
    }
}

extension JSON_RPC.Parameters {
    /// Fails unless `value` is an array or an object.
    public init?(_ value: RFC_8259.Value) {
        switch value {
        case .array(let array): self = .byPosition(array)
        case .object(let object): self = .byName(object)
        default: return nil
        }
    }

    public var value: RFC_8259.Value {
        switch self {
        case .byPosition(let array): .array(array)
        case .byName(let object): .object(object)
        }
    }
}
