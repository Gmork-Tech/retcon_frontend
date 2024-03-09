
import 'package:dart_mappable/dart_mappable.dart';

part 'ConfigProp.mapper.dart';

@MappableClass()
class ConfigProp with ConfigPropMappable {

  String name;
  ValueType kind;
  bool nullable;
  dynamic val;

  ConfigProp({
    required this.name,
    required this.kind,
    required this.nullable,
    this.val,
  });


}

@MappableEnum()
enum ValueType {
  STRING,
  NUMBER,
  BOOLEAN,
  TIMESTAMP,
  OBJECT,
  ARRAY,
}