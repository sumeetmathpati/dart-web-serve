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

## Server Configuration

The file in [`lib/src/settings.dart`](https://github.com/sumeetmathpati/hosted-pub-server/blob/main/lib/src/settings.dart) is used to store configurations for the server.

## Example Queries

### API Queries

If you are using authentication for API (i.e. if it's enables in [setting](https://github.com/sumeetmathpati/hosted-pub-server/blob/main/lib/src/settings.dart) file), use header `"Authorization: Bearer <YOUR_TOKEN>"` in each query below. Example `curl -H "Authorization: Bearer <YOUR_TOKEN>" 'http://localhost:8080/api/packages'`.

#### Get the list of all packages

```bash
curl http://localhost:8080/api/packages/
```

#### Get the information of specific package

```bash
curl http://localhost:8080/api/packages/provider
```

#### Get the information of certain package with specific version.

```bash
http://localhost:8080/api/packages/provider/versions/5.0.0
```

### Authentication Queries

Note that before using authentication features; enable it in [setting](https://github.com/sumeetmathpati/hosted-pub-server/blob/main/lib/src/settings.dart) file first.

#### Register User

```bash
curl --request POST --data '{"email": "user@example.com", "password": "password"}' http://localhost:8080/auth/register
```

#### Get Auth Token (For already registered user)

```bash
curl --request POST --data '{"email": "user@example.com", "password": "password"}' http://localhost:8080/auth/login
```

#### Logout User

```bash 
curl --request POST -H "Authorization: Bearer <YOUR_TOKEN>" http://localhost:8080/auth/logout 
```

## Converting to JS

We can convert ehe dart code into JS with dart2js package.