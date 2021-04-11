import 'package:webserver/src/html_handler.dart';
import 'package:webserver/src/middlewares.dart';
import 'package:webserver/src/package_api.dart';
import 'package:webserver/src/staticHandler.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:webserver/src/settings.dart';
import 'package:webserver/src/auth_api.dart';
import 'dart:io';
import 'dart:convert';

void main(List<String> args) async {
  final app = Router();
  final List userdb = json.decode(File('users.json').readAsStringSync());

  app.mount('/auth/', AuthApi(userdb, SECRET_KEY).router);
  app.mount('/api/', PackageApi().router);
  app.mount('/assets/', StaticHandler('templates').router);
  app.get('/about', htmlHandler('about.html'));
  app.get('/', htmlHandler('index.html'));

  final handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(handleCORS())
      .addMiddleware(handleAuth(SECRET_KEY))
      .addHandler(app);

  print('Serving at http://${HOST}:${PORT}');
  await serve(handler, HOST, PORT);
}
