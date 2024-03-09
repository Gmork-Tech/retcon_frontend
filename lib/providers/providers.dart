
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:retcon_frontend/clients/api_client.dart';
import 'package:retcon_frontend/model/ApplicationListResponse.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../model/Application.dart';
import '../model/Deployment.dart';

import 'package:collection/collection.dart';

part 'providers.g.dart';

const Uuid uuid = Uuid();

@riverpod
class NavSelection extends _$NavSelection {
  @override
  int build() {
    return 0;
  }

  void update(int newValue) {
    state = newValue;
  }
}


@riverpod
class Server extends _$Server {

  @override
  FutureOr<String?> build() {
    return getServer();
  }

  Future<String?> getServer() {
    if (kIsWeb) {
      if (kDebugMode) {
        return Future(() =>
        "${Uri.base.scheme}://${Uri.base.host}:8080");
      }
      return Future(() => Uri.base.origin);
    }
    return SharedPreferences.getInstance().then((prefs) =>
        prefs.getString("server"));
  }

  Future<void> setServer(String server) {
    if (kIsWeb) {
      return Future(() => {});
    }
    return SharedPreferences.getInstance()
        .then((prefs) =>
          prefs.setString("server", server))
        .then((value) =>
          DioClient().setBaseURL());
  }
}

@riverpod
class Auth extends _$Auth {

  @override
  String? build() {
    return null;
  }

  void setBasicAuthString(String user, String pass) {
    state = 'Basic ${base64.encode(utf8.encode('$user:$pass'))}';
    DioClient().setAuth(state);
  }

  void setBearerTokenAuthString(String token) {
    state = 'Bearer $token';
    DioClient().setAuth(state);
  }

}

@riverpod
class Apps extends _$Apps {

  @override
  FutureOr<ApplicationListResponse> build(int pageNo) async {
    var res = await DioClient().getApps(pageNo: pageNo);
    if (res.data != null) {
      return ApplicationListResponseMapper.fromJson(res.data!);
    }
    throw Exception("");
  }

}

@riverpod
class App extends _$App {

  @override
  Application build() {
    return Application(id: uuid.v4(), optimizable: true, name: "New Application");
  }

  void setApplication(Application app) {
    state = app;
  }

  void removeDeployment(Deployment deployment) {
    if(state.deployments != null) {
      var deployments = Set.of(state.deployments as Iterable<Deployment>);
      if (deployments.contains(deployment)) {
        deployments.remove(deployment);
      }
      state = state.copyWith(deployments: deployments);
    }
  }

  void addDeployment(Deployment deployment) {
    if (state.deployments == null) {
      state = state.copyWith(deployments: {deployment});
    } else {
      var deployments = Set.of(state.deployments as Iterable<Deployment>);
      deployments.add(deployment);
      state = state.copyWith(deployments: deployments);
    }
  }

  void updateDeployment(Deployment deployment) {
    if (state.deployments == null) {
      return;
    }
    if (state.deployments!.isEmpty) {
      return;
    }
    var deployments = Set.of(state.deployments as Iterable<Deployment>);
    var toBeRemoved = deployments.firstWhereOrNull((element) => element.id == deployment.id);
    if (toBeRemoved == null) {
      return;
    }
    deployments.remove(toBeRemoved);
    deployments.add(deployment);
    state = state.copyWith(deployments: deployments);
  }

  void updateDeployments(Set<Deployment> deployments) {
    state = state.copyWith(deployments: deployments);
  }

  void resetToDefaults() {
    state = build();
  }

}