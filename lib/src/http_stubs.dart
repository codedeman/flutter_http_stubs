import 'dart:async';
import 'package:http/http.dart' as http;
import 'stub_manager.dart';

class StubsClient extends http.BaseClient {
  final http.Client _inner;

  StubsClient(this._inner);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final stubResponse = await stubManager.handleRequest(request);
    return http.StreamedResponse(
      Stream.fromIterable([stubResponse.bodyBytes]),
      stubResponse.statusCode,
      headers: stubResponse.headers,
    );
  }
}
