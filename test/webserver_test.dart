import 'package:http/http.dart' as http;
import 'package:test/test.dart';
import 'dart:io';

void main() {

test('Home route test', () async {
  final response = await http.get(Uri.http('localhost:8080', '/'));
  expect(response.statusCode, HttpStatus.ok);
});

test('Static file test', () async {
  final response = await http.get(Uri.http('localhost:8080', '/assets/styles.css'));
  expect(response.statusCode, HttpStatus.ok);
});

test('Packages list test', () async {
  final response = await http.get(Uri.http('localhost:8080', '/api/packages'));
  expect(response.statusCode, HttpStatus.ok);
});

test('Specific packages test', () async {
  final response = await http.get(Uri.http('localhost:8080', '/api/packages/provider'));
  expect(response.statusCode, HttpStatus.ok);
});

test('Specific packages and specific version test', () async {
  final response = await http.get(Uri.http('localhost:8080', '/api/packages/provider/versions/5.0.0'));
  expect(response.statusCode, HttpStatus.ok);
});

}