extension JSON_RPC.Error {
    public struct Code: RawRepresentable, Sendable, Hashable {
        public var rawValue: Int

        public init(rawValue: Int) {
            self.rawValue = rawValue
        }
    }
}

extension JSON_RPC.Error.Code {
    public static let parseError = Self(rawValue: -32700)
    public static let invalidRequest = Self(rawValue: -32600)
    public static let methodNotFound = Self(rawValue: -32601)
    public static let invalidParams = Self(rawValue: -32602)
    public static let internalError = Self(rawValue: -32603)

    public var isServerError: Bool { (-32099)...(-32000) ~= rawValue }
}
