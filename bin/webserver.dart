import 'package:webserver/src/package_api.dart';
import 'package:webserver/src/staticHandler.dart';
import 'package:webserver/webserver.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:webserver/src/settings.dart';
import 'dart:io';
import "package:path/path.dart" show dirname, join;

final path = Platform.script.toFilePath();
final currentDirectory = dirname(path);
final htmlTemplatesPath = join(currentDirectory, '..', 'templates');

void main(List<String> args) async {
  final app = Router();

  app.mount('/api/', PackageApi().router);
  // app.get('/assets/<file|.*>', createStaticHandler('templates'));
  app.mount('/assets/', StaticHandler('templates').router);
  app.get('/about', htmlHandler('about.html'));
  app.get('/', htmlHandler('index.html'));



  final handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(handleCORS())
      .addHandler(app);

  print('Serving at http://${HOST}:${PORT}');
  await serve(handler, HOST, PORT);
}
