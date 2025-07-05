
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:retcon_frontend/clients/api_client.dart';
import 'package:retcon_frontend/layout/nav_layout.dart';
import 'package:retcon_frontend/layout/navless_layout.dart';

import '../pages/application_edit_page.dart';
import '../pages/applications_page.dart';
import '../pages/ask_for_server_page.dart';
import '../pages/docs_page.dart';
import '../pages/login_page.dart';
import '../pages/settings_page.dart';
import '../pages/unknown_page.dart';
import '../pages/user_edit_page.dart';
import '../pages/users_page.dart';

class RetconRouter {

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey1 = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey2 = GlobalKey<NavigatorState>();

  static final instance = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    redirect: (context, state) {
      final host = DioClient.getInstance().getBaseURL();
      if (host == "" && state.path != '/server') {
        log("Host is empty, redirecting to server page.");
        return '/server';
      }
      // Uncomment to enforce login guard:
      // final auth = ref.watch(authProvider);
      // if (auth == null && state.location != '/login') {
      //   return '/login';
      // }
      return null;
    },
    routes: <RouteBase>[
      ShellRoute(
        navigatorKey: _shellNavigatorKey1,
        builder: (context, state, child) => NavLayout(
          child: child,
        ),
        routes: <RouteBase>[
          GoRoute(
            path: '/apps',
            name: 'apps',
            builder: (context, state) => const ApplicationsPage(),
            routes: [
              GoRoute(
                path: ':id',
                builder: (context, state) => ApplicationEditPage(
                  //id: state.pathParameters['id']!,
                ),
              ),
            ],
          ),
          GoRoute(
            path: '/users',
            name: 'users',
            builder: (context, state) => const UsersPage(),
            routes: [
              GoRoute(
                path: ':id',
                builder: (context, state) => UserEditPage(
                  //id: state.pathParameters['id']!,
                ),
              ),
            ],
          ),
          GoRoute(
            path: '/settings',
            name: 'settings',
            builder: (context, state) => const SettingsPage(),
          ),
          GoRoute(
            path: '/docs',
            name: 'docs',
            builder: (context, state) => const DocsPage(),
          ),
        ],
      ),
      ShellRoute(
        navigatorKey: _shellNavigatorKey2,
        builder: (context, state, child) => NavlessLayout(
          child: child,
        ),
        routes: [
          GoRoute(
            path: '/server',
            name: 'server',
            builder: (context, state) => AskForServerPage(),
          ),
          GoRoute(
            path: '/login',
            name: 'login',
            builder: (context, state) => LoginPage(),
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => const UnknownPage(),
  );

}