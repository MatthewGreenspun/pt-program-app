import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import "package:http/http.dart" as http;
import "dart:convert";

enum Method { get, post, put, delete }

class BaseService {
  static const String baseURI = "localhost:8080";
  static const _secureStorage = FlutterSecureStorage();
  static late http.Client _client;
  String? _authToken;
  BaseService() {
    _client = http.Client();
  }

  Future<Map> request(String path, Method method,
      {Map<String, String> headers = const {},
      Map<String, dynamic> data = const {},
      bool auth = true}) async {
    final uri = Uri.http(baseURI, path);
    final Map<String, String> _headers = Map.from(headers);

    if (_authToken == null) {
      await _getLocalAuthToken();
    }
    if (auth && _authToken != null) {
      _headers['authorization'] = "Bearer $_authToken";
    }
    switch (method) {
      case Method.get:
        return _decodeResponse(await _client.get(uri, headers: _headers));
      case Method.post:
        return _decodeResponse(await _client.post(uri,
            headers: _headers, body: json.encode(data)));
      case Method.put:
        return _decodeResponse(
            await _client.put(uri, headers: _headers, body: json.encode(data)));
      case Method.delete:
        return _decodeResponse(await _client.delete(uri,
            headers: _headers, body: json.encode(data)));
    }
  }

  Future<void> setAuthToken(String token) async {
    _authToken = token;
    await _secureStorage.write(key: "token", value: token);
  }

  Future<void> _getLocalAuthToken() async {
    String? token = await _secureStorage.read(key: "token");
    _authToken = token;
  }

  Map _decodeResponse(http.Response response) {
    return jsonDecode(utf8.decode(response.bodyBytes)) as Map;
  }
}
