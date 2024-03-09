import 'package:dio/dio.dart';
import 'package:retcon_frontend/clients/storage_client.dart';

import 'api_interceptor.dart';

class DioClient {

  static final DioClient _instance = DioClient._newClient();

  static final Options jsonOptions = Options(
      responseType: ResponseType.json, contentType: "application/json");

  static final dio = Dio()..interceptors.add(CustomInterceptors());

  DioClient._newClient() {
    setBaseURL();
  }

  factory DioClient() => _instance;

  void setBaseURL() {
    getServerFromStorage().then((value) => {
      if (value != null) {
        dio.options.baseUrl=value
      }
    });
  }

  void setAuth(String? auth) {
    if (auth != null) {
      dio.options.headers.putIfAbsent("Authorization", () => auth);
      dio.options.headers.update("Authorization", (value) => auth);
    }
  }

  bool hasAuth() {
    return dio.options.headers.containsKey("Authorization") &&
        dio.options.headers["Authorization"] != null;
  }

  Future<Response<String>> getApps({required int pageNo}) {
    return dio.get("/admin/applications",
        options: jsonOptions, queryParameters: {"pageNo": pageNo});
  }

  Future<Response<Map<String, Object?>>> getApp({required int id}) {
    return dio.get("/admin/application",
        options: jsonOptions, queryParameters: {"id": id});
  }

  Future<Response<Map<String, Object?>>> getUsers({required int pageNo}) {
    return dio.get("/admin/users",
        options: jsonOptions, queryParameters: {"pageNo": pageNo});
  }

}