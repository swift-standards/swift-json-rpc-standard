import JSON_RPC_Standard
import RFC_8259
import Testing

@Suite
struct `JSON_RPC Tests` {

    @Test
    func `a request with an id reads its method, params and id`() throws {
        let request = try JSON_RPC.Request(["jsonrpc": "2.0", "id": 1, "method": "subtract", "params": [42, 23]])
        #expect(request.method == "subtract")
        #expect(request.params == [42, 23])
        #expect(request.id == .number(RFC_8259.Number(1)))
        #expect(!request.isNotification)
    }

    @Test
    func `a request without an id is a notification, a null id is not`() throws {
        #expect(try JSON_RPC.Request(["jsonrpc": "2.0", "method": "update"]).isNotification)
        #expect(try JSON_RPC.Request(["jsonrpc": "2.0", "method": "update", "id": nil]).id == .null)
    }

    @Test(arguments: [
        RFC_8259.Value(arrayLiteral: 1, 2),
        ["jsonrpc": "2.0", "id": 1],
        ["jsonrpc": "1.0", "id": 1, "method": "m"],
        ["jsonrpc": "2.0", "id": 1, "method": 1],
        ["jsonrpc": "2.0", "id": 1, "method": "m", "params": "bar"],
        ["jsonrpc": "2.0", "id": [1], "method": "m"],
    ])
    func `malformed requests are invalid requests`(value: RFC_8259.Value) {
        #expect(throws: JSON_RPC.Error(code: .invalidRequest, message: "Invalid Request")) {
            try JSON_RPC.Request(value)
        }
    }

    @Test
    func `a request round-trips through its value`() throws {
        let request = JSON_RPC.Request(method: "sum", params: ["a": 1], id: .string("x"))
        #expect(try JSON_RPC.Request(request.value) == request)
    }

    @Test
    func `a success response carries the result`() {
        let response = JSON_RPC.Response(id: .string("x"), result: .success(19))
        #expect(response.value == ["jsonrpc": "2.0", "id": "x", "result": 19])
    }

    @Test
    func `an error response carries code, message and data`() {
        let error = JSON_RPC.Error(code: .methodNotFound, message: "Method not found", data: "foo")
        let response = JSON_RPC.Response(id: .null, result: .failure(error))
        #expect(response.value == ["jsonrpc": "2.0", "id": nil, "error": ["code": -32601, "message": "Method not found", "data": "foo"]])
    }

    @Test
    func `the predefined codes match the specification`() {
        #expect([JSON_RPC.Error.Code.parseError, .invalidRequest, .methodNotFound, .invalidParams, .internalError].map(\.rawValue) == [-32700, -32600, -32601, -32602, -32603])
        #expect(JSON_RPC.Error.Code(rawValue: -32050).isServerError)
        #expect(!JSON_RPC.Error.Code.internalError.isServerError)
    }
}
