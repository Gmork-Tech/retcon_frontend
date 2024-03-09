
import 'package:dart_mappable/dart_mappable.dart';
import 'package:iso_duration_parser/iso_duration_parser.dart';
import 'package:retcon_frontend/model/Deployment.dart';
import 'package:retcon_frontend/model/validation_exception.dart';

import 'ConfigProp.dart';

part 'ByQuantityDeployment.mapper.dart';

@MappableClass(discriminatorValue: 'BY_QUANTITY')
class ByQuantityDeployment extends Deployment with ByQuantityDeploymentMappable {

  int targetQuantity;
  int? initialQuantity;
  int? incrementQuantity;
  IsoDuration? incrementDelay;
  bool shouldIncrement;

  ByQuantityDeployment({
    required super.id,
    required super.name,
    required super.kind,
    super.props,
    required this.targetQuantity,
    required this.shouldIncrement,
    this.incrementQuantity,
    this.incrementDelay,
    this.initialQuantity,
  }) : super.withProps();

  @override
  void validate() {
    if (shouldIncrement) {
      if (initialQuantity == null) {
        throw const ValidationException("Quantity based deployments require an initial deployment "
            "quantity, if incremental deployment is requested.");
      }
      if (incrementQuantity == null) {
        throw const ValidationException("Quantity based deployments require an increment quantity "
            "if incremental deployment is requested.");
      }
      if (incrementDelay == null) {
        throw const ValidationException("Quantity based deployments require an increment delay "
            "if incremental deployment is requested.");
      }
      // Todo add constants to frontend
      // if (incrementDelay!.inMilliseconds() < MIN_DELAY_MILLIS) {
      //   throw const ValidationException("Quantity based deployments require a minimum deployment delay of " +
      //       MIN_DELAY_MILLIS + "ms if incremental deployment is requested.");
      // }
    }
  }

}