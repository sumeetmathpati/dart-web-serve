import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

String generateSalt([int length = 32]) {
  final rand = Random.secure();
  final salfBytes = List<int>.generate(length, (_) => rand.nextInt(256));

  return base64Encode(salfBytes);
}

String hashPassword(String password, String salt) {
  final codec = Utf8Codec();
  final key = codec.encode(password);
  final salfBytes = codec.encode(salt);
  final hmac = Hmac(sha256, key);
  final digest = hmac.convert(salfBytes);
  return digest.toString();
}

String generateJWT(String subject, String issuer, String secret) {
  final jwt = JWT({
    'iat': DateTime.now().millisecondsSinceEpoch,
  }, subject: subject, issuer: issuer);
  return jwt.sign(SecretKey(secret));
}

dynamic verifyJWT(String token, String secret) {
  try {
    final jwt = JWT.verify(token, SecretKey(secret));
    return jwt;
  } on JWTExpiredError {} on JWTError {}
}
