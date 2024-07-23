import 'package:flutter/material.dart';
import 'package:flutter_application_1/riverpod/note_db.dart';
import 'package:flutter_application_1/screens/input_content_screen.dart';
import 'package:flutter_application_1/screens/home_screen.dart';
import 'package:flutter_application_1/riverpod/theme_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final databaseHelper = DatabaseHelper();
  await databaseHelper.initDatabase();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeNotifierProvider);
    return MaterialApp(
      theme: theme,
      routes: <String, WidgetBuilder>{
        '/contentScreen': (BuildContext context) {
          return ContentScreen();
        }
      },
      home: const HomePage(),
    );
  }
}
