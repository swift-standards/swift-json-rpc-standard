public import RFC_8259

extension JSON_RPC {
    /// An error object: a code, a short message and optional detail.
    public struct Error: Swift.Error, Sendable, Hashable {
        public var code: JSON_RPC.Error.Code
        public var message: String
        public var data: RFC_8259.Value?

        public init(code: JSON_RPC.Error.Code, message: String, data: RFC_8259.Value? = nil) {
            self.code = code
            self.message = message
            self.data = data
        }
    }
}

extension JSON_RPC.Error {
    public var value: RFC_8259.Value {
        var members: [(key: String, value: RFC_8259.Value)] = [("code", .number(RFC_8259.Number(code.rawValue))), ("message", .string(message))]
        if let data { members.append(("data", data)) }
        return .object(RFC_8259.Object(members))
    }
}
