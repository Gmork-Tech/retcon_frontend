import 'package:flutter/material.dart';

import 'CustomDataSource.dart';

class CustomTable extends StatelessWidget {

  final String headerTitle;
  final CustomDataSource dataSource;
  final List<DataColumn> columns;
  final int? sortColumnIndex;
  final bool sortAscending;

  const CustomTable({
    super.key,
    required this.headerTitle,
    required this.dataSource,
    required this.columns,
    required this.sortAscending,
    this.sortColumnIndex,
  });
  
  List<DataColumn> ensureEditingColumn(List<DataColumn> columns) {
    List<DataColumn> cols = List.from(columns, growable: true);
    if (cols.last.label != const Text("")) {
      cols.add(const DataColumn(label: Text(""),),);
    }
    return cols;
  }

  @override
  Widget build(BuildContext context) {
    return PaginatedDataTable(
      header: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(headerTitle),
        ],
      ),
      showCheckboxColumn: false,
      sortColumnIndex: sortColumnIndex,
      sortAscending: sortAscending,
      source: dataSource,
      columns: ensureEditingColumn(columns),
    );
  }
}
