import 'package:shared_preferences/shared_preferences.dart';

class StorageClient {

  static final String _SERVER_KEY = "server";

  static Future<String?> getServerFromStorage() async {
    return await SharedPreferences.getInstance()
        .then((prefs) => prefs.getString(_SERVER_KEY));
  }

  static Future<bool> setServerInStorage(String server) async {
    return await SharedPreferences.getInstance()
        .then((prefs) => prefs.setString(_SERVER_KEY, server));
  }

}

