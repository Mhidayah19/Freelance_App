import 'package:flutter/material.dart';
import 'package:flutter_application/core/extensions/hive_extensions.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:flutter_application/core/app/app.dart';
import 'package:flutter_application/dependency_injection.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await _initializeSupabase();
  await _initializeHive();
  configureDependencyInjection();

  runApp(
    const FlutterSupabaseStarterApp(),
  );
}

Future<void> _initializeSupabase() async {
  String supabaseUrl = dotenv.env['SUPABASE_URL'] ?? 'Not Found';
  String supabaseAPIKey = dotenv.env['SUPABASE_ANON_KEY'] ?? 'Not Found';
  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseAPIKey,
  );
}

Future<void> _initializeHive() async {
  await Hive.initFlutter();
  await Hive.openThemeModeBox();
}
