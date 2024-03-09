
import 'package:dart_mappable/dart_mappable.dart';
import 'package:retcon_frontend/model/Validatable.dart';

import 'Deployment.dart';

part 'Application.mapper.dart';

@MappableClass()
class Application with ApplicationMappable implements Validatable {

  String id;
  String name;
  bool optimizable;
  Set<Deployment>? deployments;

  Application({
    required this.id,
    required this.name,
    required this.optimizable,
    this.deployments,
  });

  @override
  void validate() {
    if (deployments != null) {
      for (var deployment in deployments!) {
        deployment.validate();
      }
    }
  }

}