<!-- PROJECT LOGO -->
<br />
<p align="center">
  <a href="https://github.com/sumeetmathpati/dart-web-server">
    <img src="./logo.png" alt="Logo" width="80" height="80">
  </a>

  <h3 align="center">Hosted Pub Server</h3>

  <p align="center">
    The one server, to serve them all
    <br />
  </p>
</p>

## Features

- [x] Implemented web server with Dart package [shelf](https://pub.dev/packages/shelf).
- [x] Serving static files with [shelf static](https://pub.dev/packages/shelf_static).
- [x] Compile Dart Code to Javascript
- [x] Serve a REST API (in JSON).
- [x] Rendering HTML pages.

## Implemented API endpoints

You can find a dummy pub packages data in `package.json` file present in root folder.

| Routes                | Description                                 |
| --------------------- | ------------------------------------------- |
| **GET** `/api/packages/`| Get list of packages.|
| **GET** `/api/packages/<PACKAGE>` | Get the information of specific package.|
| **GET** `/api/packages/<PACKAGE>/versions/<VERSION>`| Get the information of certain package with specific version. |


## Running Server

To run the server, enter the commands

```bash
git clone https://github.com/sumeetmathpati/dart-web-server.git
cd hosted-pub-server
dart run
```

## Example API Queries

### Get the list of all packages

```bash
curl http://localhost:8080/api/packages/
```

### Get the information of specific package

```bash
curl http://localhost:8080/api/packages/provider
```

### Get the information of certain package with specific version.

```bash
http://localhost:8080/api/packages/provider/versions/5.0.0
```

## Converting to JS

We cna convert ehe dart code into JS with dart2js package.