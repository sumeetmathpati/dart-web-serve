import 'package:pubserver/src/settings.dart';
import 'package:pubserver/src/utils.dart';
export 'package:shelf/shelf.dart';
export 'package:shelf/shelf_io.dart';
export 'package:shelf_static/shelf_static.dart';
import 'package:shelf/shelf.dart';

Middleware handleAuth(String secret) {
  return (Handler innerHandler) {
    return (Request request) async {
      final authHeader = request.headers['authorization'];
      var token, jwt;

      if (authHeader != null && authHeader.startsWith('Bearer')) {
        token = authHeader.substring(7);
        jwt = verifyJWT(token, secret);
      }

      final updateRequest = request.change(context: {
        'authDetails': jwt,
      });

      return await innerHandler(updateRequest);
    };
  };
}

Middleware checkAuthorization() {
  return createMiddleware(requestHandler: (Request request) {
    if (AUTH_ENABLE && request.context['authDetails'] == null) {
      return Response.forbidden('Not authorized to perform this action!');
    }
    return null;
  });
}

Middleware handleCORS() {
  const CORSHeader = {
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Methods': 'GET, POST',
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
