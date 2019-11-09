import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:i_kidi/constants.dart';

class ServerConnection {
  Map<String, String> headers = {};

  Future<Map> get(String url) async {
    http.Response response = await http.get(url, headers: headers);
    updateCookie(response);
    return json.decode(response.body);
  }

  Future<String> login(var body) async {
    String url = Constants.HOST_URL + Constants.LOGIN_URL;
    var bodyEncoded = json.encode(body);
    headers["Content-type"] = "application/json";
    http.Response response = await http.post(url, headers: headers, body: bodyEncoded);
    updateCookie(response);
    return response.body;
  }

  Future<String> home() async {
    String url = Constants.HOST_URL + Constants.HOME_URL;
    http.Response response = await http.post(url, headers: headers, body: "");
    return response.body;
  }

  Future<String> club(String id) async {
    String url = Constants.HOST_URL + Constants.CLUB_URL + id;
    http.Response response = await http.post(url, headers: headers, body: "");
    return response.body;
  }

  Future<String> logout() async {
    String url = Constants.HOST_URL + Constants.LOGOUT_URL;
    http.Response response = await http.post(url, headers: headers, body: "");
    headers.clear();
    return response.body;
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