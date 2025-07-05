import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:retcon_frontend/clients/storage_client.dart';

import 'api_interceptor.dart';

class DioClient {

  // private Singleton (static)
  static final DioClient _instance = DioClient._newClient();

  // Singleton instance
  static late final Dio _dio;

  // Singleton creation
  static Future<void> ensureInitialized() async {
    var client = Dio()..interceptors.add(CustomInterceptors());
    await StorageClient.getServerFromStorage().then((value) {
      if (value != null) {
        client.options.baseUrl = value;
        log("SETTING DIO BASE URI to: $value");
      } else {
        log("ERROR, NO BASE URI.");
      }
    });
    _dio = client;
  }

  static final Options jsonOptions = Options(
      responseType: ResponseType.json, contentType: "application/json");

  DioClient._newClient();

  // Static factory method to retrieve Singleton instance
  factory DioClient.getInstance() => _instance;

  String getBaseURL() {
    return _dio.options.baseUrl;
  }

  Future<void> setBaseURL(String url) async {
    bool success = await StorageClient.setServerInStorage(url);
    if (success) {
      _dio.options.baseUrl = url;
    }
  }

  void configureBasicAuth(String user, String pass) {
    String auth = 'Basic ${base64.encode(utf8.encode('$user:$pass'))}';
    _setAuth(auth);
  }

  void configureBearerTokenAuth(String token) {
    String auth = 'Bearer $token';
    _setAuth(auth);
  }

  void _setAuth(String auth) {
    _dio.options.headers.putIfAbsent("Authorization", () => auth);
    _dio.options.headers.update("Authorization", (value) => auth);
  }

  bool hasAuth() {
    return _dio.options.headers.containsKey("Authorization") &&
        _dio.options.headers["Authorization"] != null;
  }

  Future<Response<String>> getApps({required int pageNo}) {
    return _dio.get("/admin/applications",
        options: jsonOptions, queryParameters: {"pageNo": pageNo});
  }

  Future<Response<Map<String, Object?>>> getApp({required int id}) {
    return _dio.get("/admin/application",
        options: jsonOptions, queryParameters: {"id": id});
  }

  Future<Response<Map<String, Object?>>> getUsers({required int pageNo}) {
    return _dio.get("/admin/users",
        options: jsonOptions, queryParameters: {"pageNo": pageNo});
  }

}