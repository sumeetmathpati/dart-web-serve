import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_static/shelf_static.dart';
import 'package:path/path.dart' as p;

import 'middlewares.dart';

class StaticHandler {
  final folderPath;
  final String contentType = "";

  StaticHandler(this.folderPath, {contentType: ""});

  Handler get router {
    final router = Router();

    router.get('/<file|.*>', (Request req) async {
      final assetPath = p.join(folderPath, req.requestedUri.path.substring(1));

      
      if (contentType == "") {
        return await createFileHandler(assetPath)(req);
      } else {
        return await createFileHandler(assetPath, contentType: contentType)(
            req);
      }
    });

    // return router;
    final handler =
        Pipeline().addMiddleware(checkAuthorization()).addHandler(router);
    return handler;
  }
}
