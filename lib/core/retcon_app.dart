import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:yaru/settings.dart';
import 'package:yaru/theme.dart';

import '../l10n/app_localizations.dart';
import 'retcon_router.dart';

class RetconApp extends StatelessWidget {
  const RetconApp({super.key});

  @override
  Widget build(BuildContext context) {
    return YaruTheme(
      data: YaruThemeData(variant: YaruVariant.ubuntuBudgieBlue),
      builder: (context, yaru, child) {
        return MaterialApp.router(
          routerConfig: RetconRouter.instance,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''),
          ],
          theme: yaru.theme,
          darkTheme: yaru.darkTheme,
        );
      }
    );
  }
}