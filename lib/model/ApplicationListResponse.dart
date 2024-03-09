import 'package:dart_mappable/dart_mappable.dart';
import 'package:retcon_frontend/model/Application.dart';

part 'ApplicationListResponse.mapper.dart';

@MappableClass()
class ApplicationListResponse with ApplicationListResponseMappable {

  final Set<Application>? applications;
  final int totalPages;

  ApplicationListResponse({
    required this.totalPages,
    this.applications,
  });

}