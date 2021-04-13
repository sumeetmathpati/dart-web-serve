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

- [Live Server](#live-server)
- [Features](#features)
- [Implemented API endpoints](#implemented-api-endpoints)
- [Running Server](#running-server)
- [Server Configuration](#server-configuration)
- [API Documentation](#api-documentation)
- [Example Queries](#example-queries)
  - [Example Queries](#api-queries)
  - [Download Package Queriy](#download-package)
  - [Authentication Queries](#authentication-queries)
- [Converting to JS](#converting-to-js)

# Live Server

Don't want to clone and run? You can try the live server **[here](https://hosted-pub-server.herokuapp.com/).** You can try all the queries given below to this server. 

# Features

- [x] Serving **static files.**
- [x] Serve a **REST API** (in JSON).
- [x] Rendering HTML pages.
- [x] **Authentication** with **JWT.**
- [x] Compile Dart Code to Javascript
- [x] **Downlaod packages from server.**

# Implemented API endpoints

| Routes | Description | If authentication is enabled |
| - | - | - |
| **GET** `/api/packages/` | Get list of packages.| Requires Bearer token. |
| **GET** `/api/packages/<PACKAGE>` | Get the information of specific package.| Requires Bearer token. |
| **GET** `/api/packages/<PACKAGE>/versions/<VERSION>` | Get the information of certain package with specific version. | Requires Bearer token. |
| **POST** `/auth/register` | Register user. | Requires email id and password. |
| **POST** `/auth/login`  | Get token. | Requires email id and password. |
| **POST** `/auth/logout` | Logout. | Requires Bearer token. |
| **GET** `/packages/<PACKAGE>`  | This serves the packages stored in *package* folder in the root directory.| Requires Bearer token. |

# Running Server

To run the server, enter the commands

```bash
git clone https://gitlab.com/sumeetmathpati/hosted-pub-server.git
cd pub-server
dart run
```

# Server Configuration

The file in [`lib/src/settings.dart`](https://github.com/sumeetmathpati/hosted-pub-server/blob/main/lib/src/settings.dart) is used to store configurations for the server.

You can use `-h` command line argument to pass hostname.

# API Documentation

You can check API example documentation [here](https://documenter.getpostman.com/view/15345544/TzJoD184).

# Example Queries

Please note that I've used curl to make requests, you can also use GUI tool like [Postman](https://www.postman.com/downloads/).


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