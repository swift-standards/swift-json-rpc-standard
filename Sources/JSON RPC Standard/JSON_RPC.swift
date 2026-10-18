/// JSON-RPC 2.0 (jsonrpc.org/specification): the request, notification, response and error
/// objects, as values of `RFC_8259.Value`.
///
/// Reading and writing the JSON text is the JSON layer's job; batches are not modelled.
public enum JSON_RPC {}

extension JSON_RPC {
    /// The value of every object's `jsonrpc` member.
    public static let version = "2.0"
}
