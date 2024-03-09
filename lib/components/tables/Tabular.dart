
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

abstract class Tabular {

  @JsonKey(includeFromJson: false, includeToJson: false)
  bool selected = false;

  void onSelectChanged(bool? sel);

  List<DataCell> toDataCells(BuildContext context);

}