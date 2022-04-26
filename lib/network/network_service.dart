import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class NetworkService {
  static NetworkService? _instance;

  factory NetworkService() => _instance ?? NetworkService._internal();

  NetworkService._internal() {
    _instance = this;
  }

  final Dio _api = Dio();
  final String baseUrl = 'https://books-shop.empat.tech/';
  String? sessionId;
  String? xsrfToken;
  String? token;

  Dio getApiWithOptions({
    bool withXSRFToken = false,
    bool withReferer = false,
    bool isSanctum = false,
  }) {
    _api.interceptors.clear();
    _api.interceptors.add(_getInterseptors(
      withReferer: withReferer,
      withXSRFToken: withXSRFToken,
    ));
    return _api;
  }

  InterceptorsWrapper _getInterseptors({
    bool withXSRFToken = false,
    bool withReferer = false,
    bool isSanctum = false,
  }) {
    return InterceptorsWrapper(onRequest: (options, handler) {
      options.baseUrl = baseUrl;

      options.headers = {'Accept': 'application/json'};

      List<String> cookie = [];

      // print(token);
      // print('XSRF-TOKEN=$xsrfToken');
      // print('laravel_session=$sessionId');

      if (!isSanctum) {
        if (withXSRFToken) {
          if (xsrfToken != null) {
            options.headers.addAll({
              'X-XSRF-TOKEN': xsrfToken!.substring(0, xsrfToken!.length - 3),
            });
            cookie.add('XSRF-TOKEN=$xsrfToken');
          }
        }

        if (sessionId != null) {
          cookie.add('laravel_session=$sessionId');
        }

        if (cookie.isNotEmpty) {
          options.headers.addAll({
            'Cookie': cookie.join('; '),
          });
        }
      }

      // if (withReferer && !kIsWeb) {
      //   options.headers['Referer'] = baseUrl;
      // }

      if (token != null) {
        options.headers['Authorization'] = 'Bearer ' + (token ?? '');
      }

      return handler.next(options);
    });
  }

  Future<void> setToShared(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<bool> getSessionId() async {
    final prefs = await SharedPreferences.getInstance();
    String? cookie = prefs.getString('laravel_session');
    sessionId = cookie;
    return cookie != null;
  }

  Future<bool> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    String? cookie = prefs.getString('token');
    token = cookie;
    return cookie != null;
  }

  Future<void> deleteToken() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    token = null;
  }

  Future<bool> getXSRFToken() async {
    final prefs = await SharedPreferences.getInstance();
    String? cookie = prefs.getString('XSRF-TOKEN');

    xsrfToken = cookie;
    return cookie != null;
  }

  Future<void> removeCookie() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('cookies');
  }
}
