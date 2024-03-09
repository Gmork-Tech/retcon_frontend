
import 'package:dart_mappable/dart_mappable.dart';
import 'package:retcon_frontend/model/Deployment.dart';
import 'ConfigProp.dart';

part 'PartialManualDeployment.mapper.dart';

@MappableClass(discriminatorValue: 'MANUAL')
class PartialManualDeployment extends Deployment with PartialManualDeploymentMappable {

  Set<String> targetHosts;

  PartialManualDeployment({
    required super.id,
    required super.name,
    required super.kind,
    super.props,
    required this.targetHosts,
}) : super.withProps();

  @override
  void validate() {}

}