import 'package:shelf/shelf.dart';
import 'dart:io';
import 'package:path/path.dart' show dirname, join;

final path = Platform.script.toFilePath();
final currentDirectory = dirname(path);
final htmlTemplatesPath = join(currentDirectory, '..', 'templates');

Handler htmlHandler(String filePath) => (Request request) {
      final indexFile =
          File(join(htmlTemplatesPath, filePath)).readAsStringSync();
      return Response.ok(indexFile, headers: {'content-type': 'text/html'});
    };
