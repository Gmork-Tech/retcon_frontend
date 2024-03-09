import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retcon_frontend/components/DeploymentDialog.dart';
import 'package:retcon_frontend/components/edit_and_delete_button_group.dart';
import 'package:retcon_frontend/model/ByPercentDeployment.dart';
import 'package:retcon_frontend/model/ByQuantityDeployment.dart';
import 'package:retcon_frontend/model/FullDeployment.dart';
import 'package:retcon_frontend/model/PartialManualDeployment.dart';
import 'package:retcon_frontend/model/Validatable.dart';
import 'package:retcon_frontend/providers/providers.dart';

import '../components/tables/Tabular.dart';
import 'ConfigProp.dart';

part 'Deployment.mapper.dart';

@MappableClass(discriminatorKey: 'kind', includeSubClasses: [FullDeployment, PartialManualDeployment, ByPercentDeployment, ByQuantityDeployment])
abstract class Deployment extends Tabular with DeploymentMappable implements Validatable {

  int id;
  String name;
  DeploymentStrategy kind;
  Set<ConfigProp>? props;

  Deployment(this.id, this.name, this.kind, this.props);

  Deployment.withProps({
    required this.id,
    required this.name,
    required this.kind,
    this.props,
  });

  @override
  List<DataCell> toDataCells(BuildContext context) {
    List<DataCell> cells = List.empty(growable: true);
    cells.add(DataCell(Text(id.toString()),),);
    cells.add(DataCell(Text(name),),);
    cells.add(DataCell(Text(kind.name),),);
    cells.add(
      DataCell(
        Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            return EditAndDeleteButtonGroup(
              onEdit: (() async {
                context.showDeploymentDialog(this);
              }),
              onDelete: (() {
                ref.watch(appProvider.notifier)
                    .removeDeployment(this);
              }),
            );
          },
        ),
      ),
    );
    return cells;
  }

  @override
  void onSelectChanged(bool? sel) {
    if (sel != null) {
      selected = sel;
    }
  }

}

@MappableEnum(mode: ValuesMode.named)
enum DeploymentStrategy {
  FULL,
  MANUAL,
  BY_PERCENTAGE,
  BY_QUANTITY
}