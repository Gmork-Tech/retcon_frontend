
import 'package:dart_mappable/dart_mappable.dart';
import 'package:iso_duration_parser/iso_duration_parser.dart';
import 'package:retcon_frontend/model/Deployment.dart';
import 'package:retcon_frontend/model/validation_exception.dart';

import 'ConfigProp.dart';

part 'ByPercentDeployment.mapper.dart';

@MappableClass(discriminatorValue: 'BY_PERCENTAGE')
class ByPercentDeployment extends Deployment with ByPercentDeploymentMappable {

  DateTime? lastDeployed;
  bool shouldIncrement;
  IsoDuration? incrementDelay;
  int? incrementPercentage;
  int? initialPercentage;
  int targetPercentage;

  ByPercentDeployment({
    required super.id,
    required super.name,
    required super.kind,
    super.props,
    required this.shouldIncrement,
    required this.targetPercentage,
    this.lastDeployed,
    this.incrementDelay,
    this.incrementPercentage,
    this.initialPercentage,
  }) : super.withProps();

  @override
  void validate() {
    if(shouldIncrement) {
      if (initialPercentage == null) {
        throw const ValidationException("Percentage based deployments require an initial deployment "
            "percentage, if incremental deployment is requested.");
      }
      if (incrementPercentage == null) {
        throw const ValidationException("Percentage based deployments require an increment percentage "
            "if incremental deployment is requested.");
      }
      if (incrementDelay == null) {
        throw const ValidationException("Percentage based deployments require an increment delay "
            "if incremental deployment is requested.");
      }
      // Todo bring constants into frontend
      // if (incrementDelay!.inMilliseconds < MIN_DELAY_MILLIS) {
      //   throw const ValidationException("Percentage based deployments require a minimum deployment delay of " +
      //       MIN_DELAY_MILLIS + "ms if incremental deployment is requested.");
      // }
    }
  }

}