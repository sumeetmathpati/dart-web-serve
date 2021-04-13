import 'dart:io';
import 'dart:convert';
import 'package:pubserver/src/settings.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf.dart';
import 'package:pubserver/src/middlewares.dart';

class PackageApi {
  List data = json.decode(File('database/packages.json').readAsStringSync());
  
  final PORT;
  final HOST;

  PackageApi(this.HOST, this.PORT);

  Handler get router {
    final router = Router();

    // Add appropriate hostname and port number before the package path.
    data.forEach((package) {
      package['latest']['archive_url'] =
          "${HOST}:${PORT}${package['latest']['archive_url']}";

      if (package['versions'].length != 0) {
        package['versions'].forEach((version) {
          version['archive_url'] =
              "${HOST_NAME}:${PORT}${version['archive_url']}";
        });
      }
    });

    router.get('/packages', (Request request) {
      return Response.ok(json.encode(data),
          headers: {'Content-Type': 'application/vnd.pub.v2+json'});
    });

    router.get('/packages/<name>', (Request request, String name) {
      final package = data.firstWhere((package) => package['name'] == name,
          orElse: () => null);

      if (package != null) {
        return Response.ok(json.encode(package),
            headers: {'Content-Type': 'application/vnd.pub.v2+json'});
      }

      return Response.notFound('Package not found.');
    });

    router.get('/packages/<name>/versions/<version>',
        (Request request, String name, String version) {
      var package_version;
      final package = data.firstWhere((package) => package['name'] == name,
          orElse: () => null);
      final package_with_version = package["versions"];

      if (package_with_version != null) {
        package_version = package_with_version.firstWhere(
            (package_verision) => package_verision['version'] == version,
            orElse: () => null);
        if (package_version != null) {
          return Response.ok(json.encode(package_version),
              headers: {'Content-Type': 'application/vnd.pub.v2+json'});
        }
      }

      return Response.notFound('Package not found.');
    });

    final handler =
        Pipeline().addMiddleware(checkAuthorization()).addHandler(router);
    return handler;
  }
}
