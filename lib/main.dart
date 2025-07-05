import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retcon_frontend/clients/api_client.dart';
import 'package:retcon_frontend/core/retcon_app.dart';

import 'mappers/IsoDurationMapper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MapperContainer.globals.use(const IsoDurationMapper());
  await DioClient.ensureInitialized();
  runApp(const ProviderScope(child: RetconApp()));
}
