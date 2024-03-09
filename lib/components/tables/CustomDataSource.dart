

import 'package:flutter/material.dart';

import 'Tabular.dart';

class CustomDataSource<T extends Tabular> extends DataTableSource {

  final Set<T>? rows;
  final BuildContext context;

  CustomDataSource({
    required this.rows,
    required this.context,
  });

  @override
  DataRow? getRow(int index) {
    if (rows == null) {
      return null;
    }
    var maybeRow = rows!.elementAtOrNull(index);
    if (maybeRow == null) {
      return null;
    }
    return DataRow(
      cells: maybeRow.toDataCells(this.context),
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => rows == null ? 0 : rows!.length;
  @override
  int get selectedRowCount => 0;

  
}