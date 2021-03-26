import 'dart:io';
import 'dart:convert';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf.dart';

class MovieApi {
  final List data = json.decode(File('movies.json').readAsStringSync());

  Router get router {
    final router = Router();

    router.get('/', (Request request) {
      return Response.ok(json.encode(data),
          headers: {'Content-Type': 'application/json'});
    });

    router.get('/<id|[0-9]+>', (Request request, String id) {
      final parsedId = int.tryParse(id);
      final movie =
          data.firstWhere((movie) => movie['id'] == parsedId, orElse: () => null);

      if (movie != null) {
        return Response.ok(json.encode(movie),
            headers: {'Content-Type': 'application/json'});
      }

      return Response.notFound('Movie not found.');
    });

    router.post('/', (Request request) async {
      final payload = await request.readAsString();
      data.add(json.decode(payload));
      return Response.ok(payload,
          headers: {'Content-Type': 'application/json'});
    });

    router.delete('/<id>', (Request request, String id) {
      final parsedId = int.tryParse(id);
      data.removeWhere((movie) => movie['id'] == parsedId);
      return Response.ok('Deleted.');
    });

    return router;
  }
}
