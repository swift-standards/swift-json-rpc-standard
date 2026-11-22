public import RFC_8259

extension JSON_RPC {
    public struct Response: Sendable, Hashable {
        public var id: JSON_RPC.ID
        public var result: Swift::Result<IETF.RFC.`8259`.Value, JSON_RPC.Error>

        public init(id: JSON_RPC.ID, result: Swift::Result<IETF.RFC.`8259`.Value, JSON_RPC.Error>) {
            self.id = id
            self.result = result
        }
    }
}

extension JSON_RPC.Response {
    public var value: IETF.RFC.`8259`.Value {
        let outcome: (key: String, value: IETF.RFC.`8259`.Value)
        switch result {
        case .success(let value): outcome = ("result", value)
        case .failure(let error): outcome = ("error", error.value)
        }
        return .object(
            IETF.RFC.`8259`.Object([("jsonrpc", .string(JSON_RPC.version)), ("id", id.value), outcome])
        )
    }
}
