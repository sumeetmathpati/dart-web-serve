<br />
<p align="center">
  <a href="https://github.com/sumeetmathpati/dart-web-server">
    <img src="./logo.png" alt="Logo" width="80" height="80" style="border-radius: 10px:">
  </a>

  <h3 align="center">Hosted Pub Server</h3>

  <p align="center">
    The one server, to serve them all
    <br />
  </p>
</p>

# Table of Contents

- [Features](#features)
- [Implemented API endpoints](#implemented-api-endpoints)
- [Running Server](#running-server)
- [Server Configuration](#server-configuration)
- [Example Queries](#example-queries)
  - [Example Queries](#api-queries)
  - [Download Package Queriy](#download-package)
  - [Authentication Queries](#authentication-queries)
- [Converting to JS](#converting-to-js)

# Features

- [x] Serving **static files.**
- [x] Serve a **REST API** (in JSON).
- [x] Rendering HTML pages.
- [x] **Authentication** with **JWT.**
- [x] Compile Dart Code to Javascript
- [x] **Downlaod packages from server.**

# Implemented API endpoints

You can find a dummy pub packages data in `package.json` file present in root folder.

| Routes |Request Method | Description | If authentication is enabled |
| - | - | - | - |
| `/api/packages/`| GET | Get list of packages.| Requires Bearer token. |
| `/api/packages/<PACKAGE>` | GET | Get the information of specific package.| Requires Bearer token. |
| `/api/packages/<PACKAGE>/versions/<VERSION>`| GET | Get the information of certain package with specific version. | Requires Bearer token. |
| `/auth/register`|POST | Register user. | Requires email id and password. |
| `/auth/login` |POST | Get token. | Requires email id and password. |
| `/auth/logout` |POST | Logout. | Requires Bearer token. |
| `/packages/<PACKAGE>` |GET | This serves the packages stored in *package* folder in the root directory.| Requires Bearer token. |

# Running Server

To run the server, enter the commands

```bash
git clone https://github.com/sumeetmathpati/dart-web-server.git
cd hosted-pub-server
dart run
```

# Server Configuration

The file in [`lib/src/settings.dart`](https://github.com/sumeetmathpati/hosted-pub-server/blob/main/lib/src/settings.dart) is used to store configurations for the server.

# Example Queries

Please note that I've used curl to make requests, you can also use GUI tool like [Postman](https://www.postman.com/downloads/).

You can check **API example documentation [here](https://documenter.getpostman.com/view/15345544/TzJoD184)** for. For testing, you can use email ID `user@test.com` and password `password`.

## API Queries

If you are not using authentication for API (i.e. if it's disabled in [setting](https://github.com/sumeetmathpati/hosted-pub-server/blob/main/lib/src/settings.dart) file), just remove header `"Authorization: Bearer <YOUR_TOKEN>"` in each query below. Example, just use `curl http://localhost:8080/api/packages` instead of `curl -H "Authorization: Bearer <YOUR_TOKEN>" 'http://localhost:8080/api/packages'`.

See this to know about <a href="#howtogettoken">How to get token?</a>

### Get the list of all packages

```bash
curl -H "Authorization: Bearer <YOUR_TOKEN>" 'http://localhost:8080/api/packages'
```

### Get the information of specific package

```bash
curl -H "Authorization: Bearer <YOUR_TOKEN>" 'http://localhost:8080/api/packages/provider'
```

### Get the information of certain package with specific version.

```bash
curl -H "Authorization: Bearer <YOUR_TOKEN>" 'http://localhost:8080/api/packages/provider/versions/5.0.0'
```

## Download Package

```bash
curl -H "Authorization: Bearer <YOUR_TOKEN>" 'localhost:8080/package/flutter_bloc-6.1.3.tar.gz' --output ./flutter_bloc-6.1.3.tar.gz
```

## Authentication Queries

Note that, to use authentication features, enable it in [setting](https://github.com/sumeetmathpati/hosted-pub-server/blob/main/lib/src/settings.dart) file first.

### Register User

```bash
curl --request POST --data '{"email": "user@test.com", "password": "password"}' http://localhost:8080/auth/register
```

<a name="howtogettoken"></a>

### Get Auth Token (For already registered user)

To get the use id `user@test.com` and password `password`. 

```bash
curl --request POST --data '{"email": "user@test.com", "password": "password"}' http://localhost:8080/auth/login
```

### Logout User

```bash 
curl --request POST -H "Authorization: Bearer <YOUR_TOKEN>" http://localhost:8080/auth/logout 
```

# Converting to JS

We can convert ehe dart code into JS with dart2js package.