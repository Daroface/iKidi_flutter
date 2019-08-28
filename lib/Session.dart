import 'package:http/http.dart' as http;
import 'dart:convert';

class Session {
  Map<String, String> headers = {};

  Future<Map> get(String url) async {
    http.Response response = await http.get(url, headers: headers);
    updateCookie(response);
    return json.decode(response.body);
  }

  Future<int> login(String url, var body) async {
    var bodyEncoded = json.encode(body);
    headers["Content-type"] = "application/json";
    http.Response response = await http.post(url, headers: headers, body: bodyEncoded);
    updateCookie(response);
    return response.statusCode;
  }

  Future<Map> post(String url, var body) async {
    var bodyEncoded = json.encode(body);
    headers = {"Content-type": "application/json"};
    http.Response response = await http.post(url, headers: headers, body: bodyEncoded);
    return json.decode(response.body);
  }

  void updateCookie(http.Response response) {
    String rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      int start = rawCookie.indexOf('.AspNet.ApplicationCookie=');
      String tmp = "";
      tmp = rawCookie.substring(start);
      int end = tmp.indexOf('; ');
      headers['cookie'] =
      (tmp.compareTo("") == 0) ? "" : tmp.substring(0, end);
    }
  }
}