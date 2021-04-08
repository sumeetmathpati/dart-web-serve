import 'dart:io';
import "package:path/path.dart" show dirname, join;
export 'package:shelf/shelf.dart';
export 'package:shelf/shelf_io.dart';
export 'package:shelf_static/shelf_static.dart';
import 'package:shelf/shelf.dart';

final path = Platform.script.toFilePath();
final currentDirectory = dirname(path);
final htmlTemplatesPath = join(currentDirectory, '..', 'templates');

Middleware handleCORS() {
  const CORSHeader = {
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Methods': 'GET',
    'Access-Control-Allow-Headers': 'Origin, Content-Type',
  };

  return createMiddleware(
    requestHandler: (Request request) {
      if (request.method == 'OPTIONS') {
        return Response.ok('', headers: CORSHeader);
      }
      return null;
    },
    responseHandler: (Response response) {
      return response.change(headers: CORSHeader);
    },
  );
}

Handler htmlHandler(String filePath) => (Request request) {
      final indexFile = File(join(htmlTemplatesPath, filePath)).readAsStringSync();
      return Response.ok(indexFile, headers: {'content-type': 'text/html'});
    };
