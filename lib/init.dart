library req;

import 'dart:io';
import 'dart:convert';
import 'dart:async';

extension HttpClientResponseText on HttpClientResponse {
  Future<String> text({Encoding encoding = utf8}) async {
    final contents = StringBuffer();
    await for (var data in transform(encoding.decoder)) {
      contents.write(data);
    }
    return contents.toString();
  }
}

class Req {
  late final HttpClient http;
  int timeout;

  Req({this.timeout = 60}) : http = HttpClient();

  Future<HttpClientResponse> _req(
      FutureOr<HttpClientRequest> request, Map<String, String>? headers,
      {String? body}) async {
    final req = await request;
    if (headers != null) {
      for (var i in headers.entries) {
        req.headers.set(i.key, i.value);
      }
    }
    if (body != null) {
      req.headers.contentLength = body.length;
      req.write(body);
    }
    try {
      return await req.close().timeout(Duration(seconds: timeout));
    } on TimeoutException catch (_) {
      req.abort();
      rethrow;
    }
  }

  Future<HttpClientResponse> getUri(Uri url, {Map<String, String>? headers}) =>
      _req(http.getUrl(url), headers);

  Future<HttpClientResponse> get(String url, {Map<String, String>? headers}) =>
      _req(http.getUrl(Uri.parse(url)), headers);

  Future<HttpClientResponse> post(String url,
          {String? body, Map<String, String>? headers}) =>
      postUri(Uri.parse(url), body: body, headers: headers);

  Future<HttpClientResponse> postUri(Uri url,
      {String? body, Map<String, String>? headers}) async {
    final req = await http.postUrl(url);
    return _req(req, headers, body: body);
  }
}

final req = Req();
