import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retcon_frontend/components/padded_chip_with_tip.dart';
import 'package:retcon_frontend/components/padded_input_with_tip.dart';
import '../components/tables/CustomDataSource.dart';
import '../components/tables/custom_table.dart';
import '../l10n/app_localizations.dart';
import '../model/Application.dart';
import '../providers/providers.dart';

class ApplicationEditPage extends ConsumerStatefulWidget {

  const ApplicationEditPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ApplicationEditPageState();
}
class _ApplicationEditPageState extends ConsumerState<ApplicationEditPage> {

  var sortAscending = false;
  int? sortColumnIndex;

  void onSort(int index, bool ascending, Application app, WidgetRef ref) {
    if (app.deployments == null) {
      return;
    }
    var deploymentsAsList = app.deployments!.toList();
    if (index == 0) {
      if (ascending) {
        deploymentsAsList.sort((a, b) => a.id.compareTo(b.id));
      } else {
        deploymentsAsList.sort((a, b) => b.id.compareTo(a.id));
      }
    } else if (index == 1) {
      if (ascending) {
        deploymentsAsList.sort((a, b) => a.name.compareTo(b.name));
      } else {
        deploymentsAsList.sort((a, b) => b.name.compareTo(a.name));
      }
    } else {
      if (ascending) {
        deploymentsAsList.sort((a, b) => a.kind.name.compareTo(b.kind.name));
      } else {
        deploymentsAsList.sort((a, b) => b.kind.name.compareTo(a.kind.name));
      }
    }
    var newDeployments = deploymentsAsList.toSet();
    ref.watch(appProvider.notifier).updateDeployments(newDeployments);

    setState(() {
      sortAscending = ascending;
      sortColumnIndex = index;
    });

  }

  @override
  Widget build(BuildContext context) {
    var app = ref.watch(appProvider);
    return SingleChildScrollView(
      child: Center(
        child: SizedBox(
          width: 1200,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(AppLocalizations.of(context)!.add_edit_app),
                    ),
                  ),
                  PaddedInputWithTip(
                    padding: const EdgeInsets.all(8.0),
                    initialValue: app.id,
                    label: AppLocalizations.of(context)!.id,
                    suffixIcon: Icons.refresh,
                    tipMessage: AppLocalizations.of(context)!.app_id_tooltip,
                    onSuffixIconPressed: () => {},
                  ),
                  PaddedInputWithTip(
                    padding: const EdgeInsets.all(8.0),
                    initialValue: app.name,
                    label: AppLocalizations.of(context)!.name,
                    tipMessage: AppLocalizations.of(context)!.app_name_tooltip,
                  ),
                  const PaddedChipWithTip(
                    padding: EdgeInsets.all(8.0),
                    label: "Auto-Optimize",
                    selected: true,
                    tipMessage: "Choose if you want to allow deployments to be automatically optimized for performance.",
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomTable(
                            headerTitle: "Deployments",
                            dataSource: CustomDataSource(rows: app.deployments, context: context),
                            sortColumnIndex: sortColumnIndex,
                            sortAscending: sortAscending,
                            columns: <DataColumn> [
                              DataColumn(
                                label: const Text(
                                  'Id',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                                onSort: (index, ascending) => onSort(index, ascending, app, ref),
                              ),
                              DataColumn(
                                label: const Text(
                                  'Name',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                                onSort: (index, ascending) => onSort(index, ascending, app, ref),
                              ),
                              DataColumn(
                                label: const Text(
                                  'Strategy',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                                onSort: (index, ascending) => onSort(index, ascending, app, ref),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
