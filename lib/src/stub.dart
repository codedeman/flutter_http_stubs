import 'dart:convert';

class Stub {
  final String url;
  final String method;
  final Map<String, String>? headers;
  final dynamic response;
  final int statusCode;
  final Duration? delay;

  Stub({
    required this.url,
    this.method = 'GET',
    this.headers,
    required this.response,
    this.statusCode = 200,
    this.delay,
  });

  bool matches(String requestUrl, String requestMethod) {
    return requestUrl == url &&
        requestMethod.toUpperCase() == method.toUpperCase();
  }

  dynamic get responseBody {
    return response is String ? json.decode(response) : response;
  }
}
