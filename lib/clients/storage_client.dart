import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

final Future<SharedPreferences> latePrefs = SharedPreferences.getInstance();


Future<String?> getServerFromStorage() {
  if (kIsWeb) {
    if (kDebugMode) {
      return Future(() =>
      "${Uri.base.scheme}://${Uri.base.host}:8080");
    }
    return Future(() => Uri.base.origin);
  }
  return latePrefs.then((prefs) => 
      prefs.getString("server"));
}

Future<void> setServerInStorage(String server) {
  if (kIsWeb) {
    return Future(() => {});
  }
  return latePrefs.then((prefs) =>
      prefs.setString("server", server));
}