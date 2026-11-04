# swift-json-rpc-standard

Use this package when you need to read a JSON-RPC 2.0 request or build a JSON-RPC 2.0 response, working on parsed JSON as `RFC_8259.Value`. Start from `JSON_RPC.Request` on the server side and `JSON_RPC.Response` for the reply. Turning JSON text into a value and back is not part of this package, and neither are batches.

## Laws

- Requests decode from a value, and responses and errors only encode to one.
- `JSON_RPC.Request.init(_:)` requires an object whose `jsonrpc` is exactly `2.0` and whose `method` is a string. `params`, if present, must be an array or an object, and `id`, if present, must be a string, a number or null. Any other shape throws a `JSON_RPC.Error` with `JSON_RPC.Error.Code.invalidRequest` and the message `Invalid Request`. Other members are ignored.
- A request without an `id` member is a notification. A request whose `id` is null is not: its id is `JSON_RPC.ID.null`.
- Encoding writes members in a fixed order: `jsonrpc`, `method`, `params`, `id` for a request, `jsonrpc`, `id`, then `result` or `error` for a response, and `code`, `message`, `data` for an error. A missing `params`, `id` or `data` is left out. A response always has an `id`, which is null for `JSON_RPC.ID.null`.
- A request decoded from its own value is equal to the original, as long as its `params` is an array, an object or absent. `JSON_RPC.Request.init(method:params:id:)` accepts any value, so a request built with other `params` encodes to a value that fails to decode.
- `JSON_RPC.Error.Code.isServerError` is true for the codes from -32099 to -32000, the range JSON-RPC leaves to the implementation. The predefined codes are outside it.
