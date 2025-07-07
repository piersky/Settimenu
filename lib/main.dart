import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'common/fan_effect.dart';
import 'database/helper.dart';

Future<bool> isDatabaseCreated() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool('db_created') ?? false;
}

Future<void> setDatabaseCreated() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('db_created', true);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final created = await isDatabaseCreated();
  if (!created) {
    await DatabaseHelper.instance.initializeDatabase();
    await setDatabaseCreated();
  }

  runApp(const Settimenu());
}

class Settimenu extends StatelessWidget {
  const Settimenu({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Settimenu',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const FanEffectScreen(),
    );
  }
}
