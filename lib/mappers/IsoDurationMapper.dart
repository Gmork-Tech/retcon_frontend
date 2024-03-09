import 'package:dart_mappable/dart_mappable.dart';
import 'package:iso_duration_parser/iso_duration_parser.dart';

class IsoDurationMapper extends SimpleMapper<IsoDuration> {
  const IsoDurationMapper();

  @override
  IsoDuration decode(dynamic value) {
    return IsoDuration.parse(value as String);
  }

  @override
  dynamic encode(IsoDuration self) {
    return self.toIso();
  }
}