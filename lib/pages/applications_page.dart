import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:retcon_frontend/components/loading_widget.dart';
import 'package:retcon_frontend/components/status_code_widget.dart';
import 'package:retcon_frontend/model/Application.dart';
import 'package:retcon_frontend/providers/providers.dart';
import 'package:vrouter/vrouter.dart';

class ApplicationsPage extends ConsumerWidget {
  const ApplicationsPage({super.key});

  Widget genCard(Application app, BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 150,
      child: Card(
        color: Theme.of(context).colorScheme.secondary,
        child: InkWell(
          onTap: () async {
            ref.watch(appProvider.notifier).setApplication(app);
            context.vRouter.to("/apps/edit");
          },
          child: Center(
            child: Text(app.name),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var maybeApps = ref.watch(AppsProvider(1));
    return maybeApps.when(
        data: (apps) => Stack(
          children: <Widget> [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ResponsiveGridList(
                desiredItemWidth: 300,
                children: apps.applications != null ?
                apps.applications!
                    .map((app) => genCard(app, context, ref))
                    .toList() : [],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 40.0, bottom: 35.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  onPressed: () async {
                    ref.watch(appProvider.notifier).resetToDefaults();
                    context.vRouter.to("/apps/edit");
                  },
                  child: const Text("+"),
                ),
              ),
            ),
          ],
        ),
        error: (err, stacktrace) => StatusCodeWidget(key: UniqueKey(), err: err),
        loading: () => const LoadingWidget());
  }
}
