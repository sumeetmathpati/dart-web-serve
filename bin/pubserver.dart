import 'dart:io';
import 'package:pubserver/src/html_handler.dart';
import 'package:pubserver/src/middlewares.dart';
import 'package:pubserver/src/package_api.dart';
import 'package:pubserver/src/staticHandler.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:pubserver/src/settings.dart';
import 'package:pubserver/src/auth_api.dart';

void main(List<String> args) async {
  final app = Router();
  
  var portEnv = Platform.environment['PORT'];
  var port = portEnv == null ? 9999 : int.parse(portEnv);

  app.mount('/auth/', AuthApi(SECRET_KEY).router);
  app.mount('/api/', PackageApi('8080').router);
  app.mount('/assets/', StaticHandler('templates').router);
  app.mount('/packages/', StaticHandler('./').router);
  app.get('/about', htmlHandler('about.html'));
  app.get('/', htmlHandler('index.html'));

  final handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(handleCORS())
      .addMiddleware(handleAuth(SECRET_KEY))
      .addHandler(app);

  // print('Serving at http://'0.0.0.0:${PORT}');
  await serve(handler, '0.0.0.0', port);
}
