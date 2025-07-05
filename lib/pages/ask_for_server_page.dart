import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:retcon_frontend/clients/api_client.dart';

import '../l10n/app_localizations.dart';

class AskForServerPage extends StatelessWidget {
  AskForServerPage({super.key});

  final serverInputController = TextEditingController();

  Future<void> updateServer() async {
    String val = serverInputController.value.text;
    if (val != "") {
      log("Setting server value to: $val");
      await DioClient.getInstance().setBaseURL(val);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 2.0,
        child: SizedBox(
          height: 150,
          width: 300,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: serverInputController,
                    decoration: const InputDecoration(
                      labelText: 'Server URI',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      await updateServer();
                      context.go("/apps");
                    },
                    child: Text(AppLocalizations.of(context)!.submit),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
