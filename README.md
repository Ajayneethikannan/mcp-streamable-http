# MCP Streamable HTTP – TypeScript Example

A TypeScript implementation of an MCP (Model Context Protocol) **Streamable HTTP server**, based on the specification: 📄 [MCP Streamable HTTP Spec](https://modelcontextprotocol.io/specification/2025-03-26/basic/transports#streamable-http).

This example is adapted from [Invariant Labs AI's `mcp-streamable-http`](https://github.com/invariantlabs-ai/mcp-streamable-http) repository.

The server exposes two weather tools (`get-alerts` and `get-forecast`) backed by the US National Weather Service API, over a single `/mcp` HTTP endpoint that supports both POST (request/response) and GET (SSE streaming).

## 🚀 Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/Ajayneethikannan/mcp-streamable-http.git
cd mcp-streamable-http
```

### 2. Set Up the Server

Install dependencies and build:

```bash
npm install
npm run build
```

### 3. Run the Server

```bash
npm start
```

By default the server listens on the port specified by the `PORT` environment variable, falling back to `8080`. To override via CLI flag:

```bash
node build/index.js --port=9000
```

The MCP endpoint will be available at `http://localhost:<port>/mcp`.

### 4. Run with Docker (Optional)

A `Dockerfile` is included for container builds:

```bash
docker build -t mcp-streamable-http .
docker run -p 8080:8080 mcp-streamable-http
```

## 🛠️ Available Tools

| Tool | Description | Arguments |
| --- | --- | --- |
| `get-alerts` | Get active weather alerts for a US state | `state` (two-letter code, e.g. `CA`) |
| `get-forecast` | Get the weather forecast for a location | `latitude`, `longitude` |

> Note: The underlying [NWS API](https://www.weather.gov/documentation/services-web-api) only supports US locations.

## 📂 Project Structure

```
.
├── src/
│   ├── index.ts     # Express entrypoint, wires the /mcp route
│   └── server.ts    # MCPServer class, tool definitions, SSE streaming
├── Dockerfile
├── package.json
└── tsconfig.json
```

## 🔌 Connecting a Client

Point any MCP Streamable HTTP client at `http://localhost:<port>/mcp`. Each new session is initialised via a POST containing an `initialize` request; subsequent requests reuse the returned `mcp-session-id` header. A GET on the same endpoint opens an SSE stream for server-to-client notifications.
