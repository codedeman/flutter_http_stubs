import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'stub.dart';

class StubManager {
  final List<Stub> _stubs = [];

  void addStub(Stub stub) {
    _stubs.add(stub);
  }

  void clearStubs() {
    _stubs.clear();
  }

  Future<http.Response> handleRequest(http.Request request) async {
    for (var stub in _stubs) {
      if (stub.matches(request.url.toString(), request.method)) {
        if (stub.delay != null) {
          await Future.delayed(stub.delay!);
        }
        return http.Response(
          json.encode(stub.responseBody),
          stub.statusCode,
          headers: stub.headers,
        );
      }
    }
    return http.Response('Not Found', 404);
  }
}

final stubManager = StubManager();
