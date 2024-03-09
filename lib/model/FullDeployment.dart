
import 'package:dart_mappable/dart_mappable.dart';
import 'package:retcon_frontend/model/Deployment.dart';

import 'ConfigProp.dart';

part 'FullDeployment.mapper.dart';

@MappableClass(discriminatorValue: 'FULL')
class FullDeployment extends Deployment with FullDeploymentMappable {

  FullDeployment({
    required super.id,
    required super.name,
    required super.kind,
    super.props
  }) : super.withProps();

  @override
  void validate() {}

}