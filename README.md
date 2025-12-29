# LiveSpec is not just a mock generator.
It’s an attempt to treat OpenAPI as a living contract instead of a static file.

## Demo

https://github.com/user-attachments/assets/9ee1b850-3edd-42e7-be21-896c6cf01cf5


[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter&logoColor=white)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-3.10+-0175C2?logo=dart&logoColor=white)](https://dart.dev/)
[![License: AGPL v3](https://img.shields.io/badge/License-AGPLv3-blue.svg)](./LICENSE)

**Mock API Generator** is a Flutter app that takes an **OpenAPI/Swagger JSON URL**, asks a backend service to generate a **mock server**, and then lets you **browse, inspect, and test** the mocked endpoints from a clean UI.

This project is intentionally built as a “gap filler” between backend and frontend work: you can quickly turn an API contract into something interactive that frontend teams can explore and test, while backend teams iterate on real implementations.

**Project status**: Work-in-progress. The current setup is usable as a demo/prototype and will evolve rapidly.

---

## Table of contents

- [What it does](#what-it-does)
- [Important: demo backend (Render)](#important-demo-backend-render)
- [How it works](#how-it-works)
- [Features](#features)
- [Limitations (current)](#limitations-current)
- [Getting started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Run the app](#run-the-app)
- [Usage](#usage)
- [Privacy & security notes](#privacy--security-notes)
- [Configuration](#configuration)
- [Project structure](#project-structure)
- [Testing](#testing)
- [Troubleshooting](#troubleshooting)
- [Roadmap](#roadmap)
- [Contributing](#contributing)
- [License](#license)

---

## What it does

- **Input**: a publicly accessible OpenAPI/Swagger JSON URL (for example: `https://example.com/swagger.json`)
- **Output**:
  - a **mocked base URL** (the base URL of the generated mock server)
  - a list of **mocked endpoints** (path + method + metadata)
  - per-endpoint details including **parameters**, **request body schema / examples**, **response status codes**, **security**, and more
- **Action**: one-click **“Test”** for an endpoint to execute a real HTTP call against the mocked server and preview the response.

---

## Important: demo backend (Render)

Right now this app depends on a backend generator service deployed on **Render**:
- The backend service repository is available here: [MockApiGenerator](https://github.com/marjandn/mock-api-generator-server)
[MockApiGenerator](https://github.com/marjandn/mock-api-generator-server)
- The Flutter app posts your swagger URL to:  
  `https://mock-api-generator-server.onrender.com/load-swagger?page=1&limit=10`  
  (see `lib/data/remote_datasources/swagger_remote_datasource_impl.dart`)

**This is a demo setup** and is **not intended for production use**:

- **Availability/performance**: Render free-tier services can sleep, restart, or throttle—expect cold starts and occasional downtime.
- **Stability**: the demo backend may change behavior and response format while this project evolves.
- **Production readiness**: the hosted mock server is not guaranteed to be isolated, secure, or compliant with production requirements.

If you want to use this idea in production, the long-term direction is to make the mock generator **self-hostable** and/or provide a **local mode**, plus proper configuration and hardening (see [Roadmap](#roadmap)).

---

## How it works

1. You paste an OpenAPI/Swagger JSON URL into the app.
2. The app calls the backend generator service with `{ "url": "<your-url>" }`.
3. The backend returns:
   - `mockBaseUrl` (where the mocked API is hosted)
   - `endpoints` (a list describing each endpoint)
   - `info` and `pagination` (when provided)
4. The UI shows:
   - base URL (copyable)
   - API info (title/description/version when present)
   - endpoint list → endpoint details
5. When you click **Test**, the app performs a real HTTP request to the mock server and shows a preview of the response.

---

## Features

- **Generate a mock server from an OpenAPI/Swagger link**
- **Browse mocked endpoints** (method + path + tags)
- **Endpoint detail view**
  - summary (parameter counts, request body presence, response status codes)
  - grouped parameters (path/query/header/cookie)
  - request body content types and generated examples (when available)
  - security information (when provided)
- **Test endpoints from the UI**
  - automatically adds **example query parameters**
  - uses generated request body examples when available
  - shows HTTP status + truncated body preview and supports “Copy response”
- **Copyable fields** (base URL, full endpoint URL, examples, etc.)

---

## Limitations (current)

This repo is actively evolving. These are current behavior limits based on the implementation:

- **Demo backend**: hard dependency on the Render-hosted service (see above).
- **Pagination**: the app currently requests `page=1&limit=10`, so you may only get the **first 10 endpoints** from the backend response.
- **Endpoint testing fills query params only**: the test runner auto-generates **query** parameter values, but **does not yet substitute path params** (e.g. `/users/{id}`) or apply **header/cookie** params.
- **CORS / Web**: if you run the Flutter app on Web, network calls may be subject to browser CORS policies depending on the mock server configuration.
- **Public specs only**: your swagger URL must be reachable by the backend service.

---

## Getting started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- Dart SDK (comes with Flutter; this project targets **Dart 3.10+**)

### Run the app

```bash
flutter pub get
flutter run
```

---

## Usage

1. Launch the app.
2. Paste a Swagger/OpenAPI JSON URL into the **Swagger Link** input.
3. Click **Generate Mock API**.
4. Copy the **Mocked Base URL** if you want to use it externally.
5. Browse endpoints:
   - click an endpoint to open details
   - click **Test** to execute a request against the mock server
6. Copy responses or examples directly from the UI when needed.

---

## Privacy & security notes

- **Your swagger URL is sent to a remote service** (the generator backend). Do not submit private/internal specs unless you control and trust the backend.
- **Do not embed secrets** in the swagger URL (tokens, credentials, signed URLs). Assume the URL may be logged by infrastructure.
- **Mock servers are for development/testing**. Treat them as untrusted and do not route sensitive production traffic through them.

---

## Configuration

Today, the backend generator URL is hardcoded. To point the app to a different generator service, update the POST URL in:

- `lib/data/remote_datasources/swagger_remote_datasource_impl.dart`

Planned improvements include moving configuration to build-time environment variables (flavors) and/or a UI config screen (see [Roadmap](#roadmap)).

---

## Project structure

This project follows a lightweight “clean architecture” style:

- **`lib/presentation/`**: UI + shared widgets + endpoint test service used by the UI
- **`lib/domain/`**: entities + repository interface + use cases
- **`lib/data/`**: remote datasource + models + repository implementation
- **`lib/core/`**: result wrapper, base use case, exception types
- **DI**: `get_it` + `injectable` (see `lib/injectable_config.dart`)

---

## Testing

This repo includes unit tests for the data and domain layers.

```bash
flutter test
```

---

## Troubleshooting

- **Render cold starts**: the demo backend may “sleep” and take longer on the first request. If “Generate Mock API” fails once, try again after ~30–60 seconds.
- **Invalid swagger URL**: make sure the URL is a direct JSON response (not an HTML page that renders Swagger UI).
- **Path params in tests**: if an endpoint path contains placeholders (e.g. `/users/{id}`), the current test runner does not substitute them yet, so the call may fail. This is planned work (see [Roadmap](#roadmap)).

---

## Roadmap

This project is meant to become a very efficient tool to close gaps between frontend and backend teams. Planned directions:

- **Self-hostable / local mode** (no dependency on a public demo backend)
- **Configurable generator backend URL** (env/flavors + UI)
- **Full pagination** and endpoint search/filtering
- **Better request building**
  - substitute **path parameters**
  - support **headers**, **cookies**, and **auth** schemes
  - let users override parameter values and request bodies from the UI
- **Export/interop**
  - export to Postman/Insomnia collections
  - generate typed clients (Dart/TS) from the same contract
- **Contract-driven workflows**
  - compare swagger versions (diff)
  - detect breaking changes
  - generate fixtures for frontend tests
- **Quality & DX**
  - improved error reporting
  - caching and offline-friendly behavior
  - automated CI for analyze/test/build

If you’re interested in collaborating, contributions and ideas are welcome (see below).

---

## Contributing

Contributions are welcome—especially around the roadmap items.

- **Bug reports**: please include reproduction steps and, if possible, a sample swagger JSON URL that demonstrates the issue.
- **PRs**: keep changes focused; include UI screenshots or short clips when you change UX.

Development notes:

- This repo uses `injectable`. If you add new injectable services, you may need to re-generate files via build runner.

---

## License

This project is licensed under the **GNU Affero General Public License v3.0 (AGPL-3.0)**.

See [`LICENSE`](./LICENSE) for details.

