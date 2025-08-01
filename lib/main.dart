import 'package:flutter/material.dart';
import 'package:settimenu/ui/debug.dart';
import 'package:settimenu/ui/menus.dart';
import 'package:settimenu/ui/settings.dart';
import 'package:settimenu/utils/costants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'common/fan_effect.dart';
import 'database/database_data.dart';
import 'database/helper.dart';

Future<bool> isDatabaseCreated() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool(kDatabaseCreated) ?? false;
}

Future<void> setDatabaseCreated() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool(kDatabaseCreated, true);
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
      title: kAppName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const FanEffectScreen(),
      routes: {
        SettingsUI.id: (context) => const SettingsUI(),
        DebugUI.id: (context) => const DebugUI(),
        DatabaseDataUI.id: (context) => const DatabaseDataUI(),
        MenusUI.id: (context) => const MenusUI(),
      },
    );
  }
}
