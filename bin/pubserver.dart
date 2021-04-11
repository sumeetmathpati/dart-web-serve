import 'package:pubserver/src/html_handler.dart';
import 'package:pubserver/src/middlewares.dart';
import 'package:pubserver/src/package_api.dart';
import 'package:pubserver/src/staticHandler.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:pubserver/src/settings.dart';
import 'package:pubserver/src/auth_api.dart';
import 'dart:io';
import 'dart:convert';

void main(List<String> args) async {
  final app = Router();
  final List userdb = json.decode(File('users.json').readAsStringSync());

  app.mount('/auth/', AuthApi(userdb, SECRET_KEY).router);
  app.mount('/api/', PackageApi().router);
  app.mount('/assets/', StaticHandler('templates').router);
  app.mount('/packages/', StaticHandler('./').router);
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
