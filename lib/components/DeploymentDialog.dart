import 'package:flutter/material.dart';
import 'package:iso_duration_parser/iso_duration_parser.dart';
import 'package:retcon_frontend/components/padded_dropdown_with_tip.dart';
import 'package:retcon_frontend/components/padded_input_with_tip.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:retcon_frontend/model/ByPercentDeployment.dart';
import 'package:retcon_frontend/model/ByQuantityDeployment.dart';
import 'package:retcon_frontend/model/FullDeployment.dart';
import 'package:retcon_frontend/model/PartialManualDeployment.dart';

import '../model/Deployment.dart';

extension DeploymentDialog on BuildContext {

  List<Widget> _getManualDeploymentWidgets(PartialManualDeployment deployment, BuildContext ctx, void Function(void Function()) setState) {
    List<Widget> widgets = List.empty(growable: true);
    widgets.add(const Text("MANUAL SELECTED"));
    return widgets;
  }

  List<Widget> _getFullDeploymentWidgets(FullDeployment deployment, BuildContext ctx, void Function(void Function()) setState) {
    List<Widget> widgets = List.empty(growable: true);
    return widgets;
  }

  List<Widget> _getByQuantityDeploymentWidgets(ByQuantityDeployment deployment, BuildContext ctx, void Function(void Function()) setState) {
    return List.of([
      PaddedInputWithTip(
        initialValue: "0",
        label: AppLocalizations.of(ctx)!.increment_quantity,
        tipMessage: AppLocalizations.of(ctx)!.increment_quantity_tip,
        padding: const EdgeInsets.all(8.0),
      ),
      PaddedInputWithTip(
        initialValue: "0",
        label: AppLocalizations.of(ctx)!.target_quantity,
        tipMessage: AppLocalizations.of(ctx)!.target_quantity_tip,
        padding: const EdgeInsets.all(8.0),
      ),
      PaddedInputWithTip(
        initialValue: "0",
        label: AppLocalizations.of(ctx)!.initial_quantity,
        tipMessage: AppLocalizations.of(ctx)!.initial_quantity_tip,
        padding: const EdgeInsets.all(8.0),
      ),
      Slider(
        value: deployment.incrementDelay != null
            ? deployment.incrementDelay!.seconds : 0,
        min: 0.0,
        max: 100.0,
        onChanged: (val) => {
          setState(() {
            deployment.incrementDelay = IsoDuration(seconds: val);
          })
        },
      ),
    ]);
  }

  List<Widget> _getByPercentDeploymentWidgets(ByPercentDeployment deployment, BuildContext ctx, void Function(void Function()) setState) {
    return List.of([
      PaddedInputWithTip(
        initialValue: "0",
        label: AppLocalizations.of(ctx)!.increment_percent,
        tipMessage: AppLocalizations.of(ctx)!.increment_percent_tip,
        padding: const EdgeInsets.all(8.0),
      ),
      PaddedInputWithTip(
        initialValue: "0",
        label: AppLocalizations.of(ctx)!.target_percent,
        tipMessage: AppLocalizations.of(ctx)!.target_percent_tip,
        padding: const EdgeInsets.all(8.0),
      ),
      PaddedInputWithTip(
        initialValue: "0",
        label: AppLocalizations.of(ctx)!.initial_percent,
        tipMessage: AppLocalizations.of(ctx)!.initial_percent_tip,
        padding: const EdgeInsets.all(8.0),
      ),
      Slider(
        value: deployment.incrementDelay != null
            ? deployment.incrementDelay!.seconds : 0,
        min: 0.0,
        max: 100.0,
        onChanged: (val) => {
          setState(() {
            deployment.incrementDelay = IsoDuration(seconds: val);
          })
        },
      ),
    ]);
  }

  List<Widget> _getWidgets(Deployment deployment, BuildContext ctx, void Function(void Function()) setState) {

    // Default widgets for all deployment types pre-populated
    List<Widget> widgets = List.of([
      PaddedInputWithTip(
        padding: const EdgeInsets.all(8.0),
        initialValue: deployment.name,
        width: 200,
        label: AppLocalizations.of(ctx)!.name,
        tipMessage: AppLocalizations.of(ctx)!.dep_name_tooltip,
      ),
      PaddedDropdownWithTip(
        padding: const EdgeInsets.all(8.0),
        label: AppLocalizations.of(ctx)!.strategy,
        tipMessage: AppLocalizations.of(ctx)!.dep_kind_tooltip,
        initialValue: deployment.kind,
        values: DeploymentStrategy.values.map((strategy) =>
            DropdownMenuEntry(value: strategy, label: strategy.name),
        ).toList(),
        onSelected: (strategy) =>
            setState(() {
              if (strategy != null) {
                deployment.kind = strategy;
              }
            }),
      ),
    ]);

    // Switch to add the remaining widgets by strategy
    switch (deployment.kind) {
      case DeploymentStrategy.MANUAL:
        widgets.addAll(_getManualDeploymentWidgets(deployment as PartialManualDeployment, ctx, setState));
      case DeploymentStrategy.FULL:
        widgets.addAll(_getFullDeploymentWidgets(deployment as FullDeployment, ctx, setState));
      case DeploymentStrategy.BY_PERCENTAGE:
        widgets.addAll(_getByPercentDeploymentWidgets(deployment as ByPercentDeployment, ctx, setState));
      case DeploymentStrategy.BY_QUANTITY:
        widgets.addAll(_getByQuantityDeploymentWidgets(deployment as ByQuantityDeployment, ctx, setState));
    }
    return widgets;
  }

  Future<void> showDeploymentDialog(Deployment deployment) =>
      showDialog<Deployment>(
          context: this,
          builder: (ctx) =>
              StatefulBuilder(
                  builder: (context, setState) {
                    return AlertDialog(
                      title: deployment.id != 0 ?
                      Text(AppLocalizations.of(ctx)!.edit_deployment)
                          : Text(AppLocalizations.of(ctx)!.add_deployment),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _getWidgets(deployment, ctx, setState),
                      ),
                      actions: [
                        MaterialButton(
                          onPressed: () => Navigator.pop(ctx),
                          child: Text(AppLocalizations.of(ctx)!.cancel),
                        ),
                        MaterialButton(
                          onPressed: () => Navigator.pop(ctx, true),
                          child: Text(AppLocalizations.of(ctx)!.edit),
                        )
                      ],
                    );
                  }
              )
      );
}