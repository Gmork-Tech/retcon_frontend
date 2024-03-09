import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:retcon_frontend/mappers/IsoDurationMapper.dart';
import 'package:vrouter/vrouter.dart';
import 'package:yaru/yaru.dart';
import 'layout/layout.dart';

import 'package:retcon_frontend/clients/storage_client.dart';
import 'package:retcon_frontend/pages/application_edit_page.dart';
import 'package:retcon_frontend/pages/applications_page.dart';
import 'package:retcon_frontend/pages/ask_for_server_page.dart';
import 'package:retcon_frontend/pages/docs_page.dart';
import 'package:retcon_frontend/pages/login_page.dart';
import 'package:retcon_frontend/pages/settings_page.dart';
import 'package:retcon_frontend/pages/unknown_page.dart';
import 'package:retcon_frontend/pages/user_edit_page.dart';
import 'package:retcon_frontend/pages/users_page.dart';
import 'package:retcon_frontend/providers/providers.dart';

void main() {
  // Add a mapper for ISO formatted Durations
  MapperContainer.globals.use(const IsoDurationMapper());
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  Future<void> doPageGuardTask(VRedirector vRedirector, WidgetRef ref) async {
    String? host = await getServerFromStorage();
    String? auth = ref.watch(authProvider);
    if (host == null) {
      vRedirector.toNamed("server");
    }
    // Todo uncomment me
    // if (auth == null) {
    //   vRedirector.toNamed("login");
    // }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return VRouter(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English, no country code
      ],
      builder: (context, child) => YaruTheme(
        data: AppTheme.of(context),
        child: child,
      ),
      debugShowCheckedModeBanner: false,
      title: "retcon",
      initialUrl: "/apps/",
      routes: [
        VNesterBase(
          widgetBuilder: (child) => Layout(
            key: UniqueKey(),
            child: child,
          ),
          nestedRoutes: [
            VGuard(
              beforeEnter: (vRedirector) =>
                  doPageGuardTask(vRedirector, ref),
              beforeUpdate: (vRedirector) =>
                  doPageGuardTask(vRedirector, ref),
              stackedRoutes: [
                VWidget(
                  path: "/apps/",
                  name: "apps",
                  widget: const ApplicationsPage(),
                  stackedRoutes: [
                    VWidget(
                      path: ":id",
                      widget: const ApplicationEditPage(),
                    ),
                  ],
                ),
                VWidget(
                  path: "/users/",
                  name: "users",
                  widget: const UsersPage(),
                  stackedRoutes: [
                    VWidget(
                      path: ":id",
                      widget: const UserEditPage(),
                    ),
                  ],
                ),
                VWidget(
                  path: "/settings",
                  name: "settings",
                  widget: const SettingsPage(),
                ),
                VWidget(
                  path: "/docs",
                  name: "docs",
                  widget: const DocsPage(),
                ),
              ],
            ),
            VWidget(
                path: "/server",
                name: "server",
                widget: AskForServerPage(),
            ),
            VWidget(
                path: "/login",
                name: "login",
                widget: LoginPage(),
            ),
            VWidget(
                path: "/unknown",
                name: "unknown",
                widget: const UnknownPage(),
            ),
          ],
        ),
        VRouteRedirector(
            path: '*',
            redirectTo: '/unknown',
        ),
      ],
    );
  }
}

class AppTheme {
  static YaruThemeData of(BuildContext context) {
    return SharedAppData.getValue(
      context,
      'theme',
      () => const YaruThemeData(variant: YaruVariant.viridian),
    );
  }

  static void apply(BuildContext context, {YaruVariant? variant, bool? highContrast, ThemeMode? themeMode,}) {
    SharedAppData.setValue(
      context,
      'theme',
      AppTheme.of(context).copyWith(
        themeMode: themeMode,
        variant: variant,
        highContrast: highContrast,
      ),
    );
  }

}
