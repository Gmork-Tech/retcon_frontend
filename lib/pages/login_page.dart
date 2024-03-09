import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retcon_frontend/providers/providers.dart';
import 'package:tabbed_card/tabbed_card.dart';
import 'package:vrouter/vrouter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginPage extends ConsumerWidget {
  LoginPage({super.key});

  final TextEditingController userController = TextEditingController();
  final TextEditingController idpUserController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController idpPassController = TextEditingController();

  Future<void> submitAuth(BuildContext ctx, WidgetRef ref, bool isIDP) async {
    var provider = ref.watch(authProvider.notifier);
    String? user;
    String? pass;
    if (isIDP) {
      user = idpUserController.value.text;
      pass = idpPassController.value.text;
      if (user != "" && pass != "") {
        // Todo: Attempt authentication against auth server
      }
    } else {
      user = userController.value.text;
      pass = passController.value.text;
      if (user != "" && pass != "") {
        provider.setBasicAuthString(user, pass);
      }
    }
    var prev = ctx.vRouter.previousPath;
    if (prev != null && prev != ctx.vRouter.path) {
      print("prev is $prev");
      ctx.vRouter.to(prev);
    } else {
      ctx.vRouter.toNamed("apps");
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Form(
      child: Center(
        child: SizedBox(
          width: 350,
          child: TabbedCard(
            elevation: 2.0,
            tabs: [
              TabbedCardItem(
                label: "Login",
                child: SizedBox(
                  width: 350,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'RETCON',
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: userController,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!.username,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: passController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!.password,
                          ),
                          onFieldSubmitted: (ignored) async =>
                            await submitAuth(context, ref, false),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: ElevatedButton(
                            onPressed: () async =>
                              await submitAuth(context, ref, false),
                            child: Text(AppLocalizations.of(context)!.submit),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              TabbedCardItem(
                label: "Login w/ IdP",
                child: SizedBox(
                  width: 350,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'RETCON',
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: idpUserController,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!.username,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: idpPassController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!.password,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: ElevatedButton(
                            onPressed: () async =>
                              await submitAuth(context, ref, true),
                            child: Text(AppLocalizations.of(context)!.submit),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
