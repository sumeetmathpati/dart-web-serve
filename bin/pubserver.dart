import 'dart:io';
import 'package:pubserver/src/html_handler.dart';
import 'package:pubserver/src/middlewares.dart';
import 'package:pubserver/src/package_api.dart';
import 'package:pubserver/src/staticHandler.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:pubserver/src/settings.dart';
import 'package:pubserver/src/auth_api.dart';
import 'package:args/args.dart';
import 'package:args/args.dart';

void main(List<String> args) async {
  final app = Router();
  var parser = ArgParser();

  parser.addOption('host', abbr: 'h');
  var results = parser.parse(args);
  
  // Get hostname and port number
  var portEnv = Platform.environment['PORT'];
  var port = portEnv == null ? PORT_NUMBER : int.parse(portEnv);
  var host = results['host'] != null ? results['host'] : HOST_NAME;

  app.mount('/auth/', AuthApi(SECRET_KEY).router);
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

  print('Serving at http://${host}:${port}');
  await serve(handler, host, port);
}
