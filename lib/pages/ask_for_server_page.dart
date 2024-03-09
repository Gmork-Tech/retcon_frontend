import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retcon_frontend/providers/providers.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AskForServerPage extends ConsumerWidget {
  AskForServerPage({super.key});

  final serverInputController = TextEditingController();

  Future<void> updateServer(WidgetRef ref) async {
    String val = serverInputController.value.text;
    if(val != "") {
      var prov = ref.read(serverProvider.notifier);
      prov.setServer(val);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final maybeServer = ref.watch(serverProvider);
    return maybeServer.when(
        data: (server) => Center(
          child: Card(
            elevation: 2.0,
            child: SizedBox(
              height: 450,
              width: 300,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        initialValue: server,
                        decoration: const InputDecoration(
                          labelText: 'Server Name',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () => updateServer(ref),
                        child: Text(AppLocalizations.of(context)!.submit),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        error: (err, stacktrace) => Container(),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
    );
  }
}
