public import RFC_8259

extension JSON_RPC {
    public struct Request: Sendable, Hashable {
        public var method: String
        public var params: RFC_8259.Value?
        public var id: JSON_RPC.ID?

        public init(method: String, params: RFC_8259.Value? = nil, id: JSON_RPC.ID?) {
            self.method = method
            self.params = params
            self.id = id
        }
    }
}

extension JSON_RPC.Request {
    public init(_ value: RFC_8259.Value) throws(JSON_RPC.Error) {
        guard let object = value.object,
            object["jsonrpc"]?.string == JSON_RPC.version,
            let method = object["method"]?.string
        else { throw JSON_RPC.Error(code: .invalidRequest, message: "Invalid Request") }
        let params = object["params"]
        if let params, params.array == nil, params.object == nil {
            throw JSON_RPC.Error(code: .invalidRequest, message: "Invalid Request")
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

    public var value: RFC_8259.Value {
        var members: [(key: String, value: RFC_8259.Value)] = [
            ("jsonrpc", .string(JSON_RPC.version)), ("method", .string(method)),
        ]
        if let params { members.append(("params", params)) }
        if let id { members.append(("id", id.value)) }
        return .object(RFC_8259.Object(members))
    }
}
