public import RFC_8259

extension JSON_RPC {
    public enum ID: Sendable, Hashable {
        case string(String)
        case number(RFC_8259.Number)
        case null
    }
}

extension JSON_RPC.ID {
    public init?(_ value: RFC_8259.Value) {
        switch value {
        case .string(let string): self = .string(string)
        case .number(let number): self = .number(number)
        case .null: self = .null
        default: return nil
        }
    }

    public var value: RFC_8259.Value {
        switch self {
        case .string(let string): .string(string)
        case .number(let number): .number(number)
        case .null: .null
        }
    }
}
