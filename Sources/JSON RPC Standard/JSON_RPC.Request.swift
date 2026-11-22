public import RFC_8259

extension JSON_RPC {
    public struct Request: Sendable, Hashable {
        public var method: String
        public var params: JSON_RPC.Parameters?
        public var id: JSON_RPC.ID?

        public init(method: String, params: JSON_RPC.Parameters? = nil, id: JSON_RPC.ID?) {
            self.method = method
            self.params = params
            self.id = id
        }
    }
}

extension JSON_RPC.Request {
    public init(_ value: IETF.RFC.`8259`.Value) throws(JSON_RPC.Error) {
        guard let object = value.object,
            object["jsonrpc"]?.string == JSON_RPC.version,
            let method = object["method"]?.string
        else { throw JSON_RPC.Error(code: .invalidRequest, message: "Invalid Request") }
        var params: JSON_RPC.Parameters?
        if let member = object["params"] {
            guard let parsed = JSON_RPC.Parameters(member) else {
                throw JSON_RPC.Error(code: .invalidRequest, message: "Invalid Request")
            }
            params = parsed
        }
        var id: JSON_RPC.ID?
        if let member = object["id"] {
            guard let parsed = JSON_RPC.ID(member) else {
                throw JSON_RPC.Error(code: .invalidRequest, message: "Invalid Request")
            }
            id = parsed
        }
        self.init(method: method, params: params, id: id)
    }

    public var isNotification: Bool { id == nil }

    public var value: IETF.RFC.`8259`.Value {
        var members: [(key: String, value: IETF.RFC.`8259`.Value)] = [
            ("jsonrpc", .string(JSON_RPC.version)), ("method", .string(method)),
        ]
        if let params { members.append(("params", params.value)) }
        if let id { members.append(("id", id.value)) }
        return .object(IETF.RFC.`8259`.Object(members))
    }
}
