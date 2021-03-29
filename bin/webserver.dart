import 'package:webserver/src/package_api.dart';
import 'package:webserver/src/staticHandler.dart';
import 'package:webserver/webserver.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:webserver/src/settings.dart';

void main(List<String> args) async {
  // final String HOST = 'localhost';
  // final int PORT = 8080;

  final app = Router();

  app.mount('/api/packages/', PackageApi().router);
  // app.get('/assets/<file|.*>', createStaticHandler('templates'));
  app.mount('/assets/', StaticAssetsApi('templates').router);
  app.all('/', htmlHandler('index.html'));
  

  final handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(handleCORS())
      .addHandler(app);

  print('Serving at http://${HOST}:${PORT}');
  await serve(handler, HOST, PORT);
}
