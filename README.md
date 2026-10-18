# swift-json-rpc-standard

![Development Status](https://img.shields.io/badge/status-active--development-blue.svg)
[![CI](https://github.com/swift-standards/swift-json-rpc-standard/workflows/CI/badge.svg)](https://github.com/swift-standards/swift-json-rpc-standard/actions/workflows/ci.yml)

JSON-RPC 2.0 specification types for Swift.

## Overview

swift-json-rpc-standard models the [JSON-RPC 2.0 specification](https://www.jsonrpc.org/specification) as values of `RFC_8259.Value`: `JSON_RPC.Request` (a notification when it has no `id`), `JSON_RPC.Response`, `JSON_RPC.Error` with the predefined `JSON_RPC.Error.Code`s, and `JSON_RPC.ID`.

Requests decode from a value and check the request-object rules; responses and errors encode to one. Reading and writing JSON text belongs to the JSON layer (swift-json), and batches are not modelled.

## Products

- `JSON RPC Standard` (module `JSON_RPC_Standard`).

## Installation

```swift
dependencies: [
    .package(url: "https://github.com/swift-standards/swift-json-rpc-standard.git", branch: "main")
]
```

```swift
.target(
    name: "YourTarget",
    dependencies: [
        .product(name: "JSON RPC Standard", package: "swift-json-rpc-standard"),
    ]
)
```

## Quick Start

```swift
import JSON_RPC_Standard

let request = try JSON_RPC.Request(["jsonrpc": "2.0", "id": 1, "method": "subtract", "params": [42, 23]])
let response = JSON_RPC.Response(id: request.id ?? .null, result: .success(19))
response.value // {"jsonrpc": "2.0", "id": 1, "result": 19}
```

## License

Apache 2.0. See [LICENSE.md](LICENSE.md).
