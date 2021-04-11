import 'dart:io';
import 'dart:convert';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf.dart';
import 'package:webserver/src/utils.dart';

class AuthApi {
  List authdb;
  String secret;

  AuthApi(this.authdb, this.secret);

  Router get router {
    final router = Router();

    router.post('/register', (Request request) async {
      final payload = await request.readAsString();
      final userInfo = json.decode(payload);
      final email = userInfo['email'];
      final password = userInfo['password'];

      // Make sure that email and password is not empty.
      if (email == null ||
          email.isEmpty ||
          password == null ||
          password.isEmpty) {
        return Response(HttpStatus.badRequest,
            body: 'Please enter email and pssword!');
      }

      // Make euse email is not already used.
      final user = authdb.firstWhere((user) => user['email'] == email,
          orElse: () => null);
      if (user != null) {
        return Response(HttpStatus.badRequest,
            body: 'This email us already exist!');
      }

      // Create account
      final salt = generateSalt();
      final hashedPassword = hashPassword(password, salt);
      authdb.add({'email': email, 'password': hashedPassword, 'salt': salt});
      print(authdb);

      return Response.ok('Registration successful!');
    });

    router.post('/login', (Request request) async {
      final payload = await request.readAsString();
      final userInfo = json.decode(payload);
      final email = userInfo['email'];
      final password = userInfo['password'];

      // Make sure that email and password is not empty.
      if (email == null ||
          email.isEmpty ||
          password == null ||
          password.isEmpty) {
        return Response(HttpStatus.badRequest,
            body: 'Please enter email and pssword!');
      }

      // Get user from DB of given email
      final user = authdb.firstWhere((user) => user['email'] == email,
          orElse: () => null);

      // If user is not present
      if (user == null) {
        return Response.forbidden('Incorrect user and/or password!');
      }

      final hashedPassword = hashPassword(password, user['salt']);
      if (hashedPassword != user['password']) {
        return Response.forbidden('Incorrect user and/or password!');
      }

      // Generate JWT
      final token = generateJWT(user['email'], 'http://localhost', secret);

      return Response.ok(json.encode({'token': token}), headers: {
        HttpHeaders.contentTypeHeader: ContentType.json.mimeType,
      });
    });

    router.post('/logout', (Request request) async {
      if (request.context['authDetails'] == null) {
        return Response.forbidden('Not authorized to perform this action!');
      }

      return Response.ok('Successfully logged out!');
    });

    return router;
  }
}

