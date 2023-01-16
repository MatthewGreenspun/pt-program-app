import "package:http/http.dart" as http;
import "dart:convert";

enum Method { get, post, put, delete }

class BaseService {
  static const String baseURI = "localhost:8080";
  static late http.Client _client;
  BaseService() {
    _client = http.Client();
  }

  Future<Map> request(String path, Method method,
      {Map<String, String> headers = const {},
      Map<String, dynamic> data = const {}}) async {
    final uri = Uri.http(baseURI, path);
    switch (method) {
      case Method.get:
        return _decodeResponse(await _client.get(uri, headers: headers));
      case Method.post:
        return _decodeResponse(
            await _client.post(uri, headers: headers, body: data));
      case Method.put:
        return _decodeResponse(
            await _client.put(uri, headers: headers, body: data));
      case Method.delete:
        return _decodeResponse(
            await _client.delete(uri, headers: headers, body: data));
    }
  }

  Map _decodeResponse(http.Response response) {
    return jsonDecode(utf8.decode(response.bodyBytes)) as Map;
  }
}
