public import RFC_8259

extension JSON_RPC {
    public struct Error: Swift::Error, Sendable, Hashable {
        public var code: JSON_RPC.Error.Code
        public var message: String
        public var data: IETF.RFC.`8259`.Value?

        public init(code: JSON_RPC.Error.Code, message: String, data: IETF.RFC.`8259`.Value? = nil) {
            self.code = code
            self.message = message
            self.data = data
        }
    }
}

extension JSON_RPC.Error {
    public var value: IETF.RFC.`8259`.Value {
        var members: [(key: String, value: IETF.RFC.`8259`.Value)] = [
            ("code", .number(IETF.RFC.`8259`.Number(code.rawValue))), ("message", .string(message)),
        ]
        if let data { members.append(("data", data)) }
        return .object(IETF.RFC.`8259`.Object(members))
    }
}
