// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sbku_app/presentation/screens/home/home_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env.development");
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'SBKU App',
    theme: ThemeData(primarySwatch: Colors.orange, useMaterial3: true),
    home: const HomePageScreen(),
  ));
}
