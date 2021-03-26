<!-- PROJECT LOGO -->
<br />
<p align="center">
  <a href="https://github.com/sumeetmathpati/dart-web-server">
    <img src="./logo.png" alt="Logo" width="80" height="80">
  </a>

  <h3 align="center">Dart Pub Server</h3>

  <p align="center">
    A minimal web server in dart
    <br />
  </p>
</p>

## Features

- Implemented web server with Dart package [shelf](https://pub.dev/packages/shelf).
- Serving static files with [shelf static](https://pub.dev/packages/shelf_static)
- Implemented example REST APIs:
  - **List all packages**
    - **GET** `<PUB_HOSTED_URL>/api/packages`
    - **Headers:** `Accept: application/vnd.pub.v2+json`
    - **Response:** `Content-Type: application/vnd.pub.v2+json`
  - **List all versions of a package**
    - **GET** `<PUB_HOSTED_URL>/api/packages/<PACKAGE>`
    - **Headers:** `Accept: application/vnd.pub.v2+json`
    - **Response:** `Content-Type: application/vnd.pub.v2+json`
  - **(Deprecated) Inspect a specific version of a package**
    - **GET** `<PUB_HOSTED_URL>/api/packages/<PACKAGE>/versions/<VERSION>`
    - **Headers:** `Accept: application/vnd.pub.v2+json`
    - **Response:** `Content-Type: application/vnd.pub.v2+json`


## Running Server

To run the server
    - clone the project: `git clone https://github.com/sumeetmathpati/dart-web-server.git`
    - Open the downloaded code directory: `cd hosted-pub-server`
    - Run the app with dart: `dart bin/webserver.dart`

## API Queries

I've implemented some JSON API endpoints, and their examples are given below.

- To get the list of packages:
    - `curl http://localhost:8080/api/packages/<PACKAGE>`
- To get the list of all versions of package:
    - `curl http://localhost:8080/api/packages/<PACKAGE>`
- To get the details about specific movie:
    - `curl http://localhost:8080/api/packages/<PACKAGE>/versions/<VERSION>`
