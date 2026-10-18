extension JSON_RPC.Error {
    /// An error code. -32768 to -32000 are reserved by the specification.
    public struct Code: RawRepresentable, Sendable, Hashable {
        public var rawValue: Int

        public init(rawValue: Int) {
            self.rawValue = rawValue
        }
    }
}

extension JSON_RPC.Error.Code {
    /// Invalid JSON was received.
    public static let parseError = Self(rawValue: -32700)
    /// The JSON sent is not a valid request object.
    public static let invalidRequest = Self(rawValue: -32600)
    /// The method does not exist or is not available.
    public static let methodNotFound = Self(rawValue: -32601)
    /// Invalid method parameters.
    public static let invalidParams = Self(rawValue: -32602)
    /// Internal JSON-RPC error.
    public static let internalError = Self(rawValue: -32603)

    /// True for -32099 to -32000, reserved for implementation-defined server errors.
    public var isServerError: Bool { (-32099)...(-32000) ~= rawValue }
}
