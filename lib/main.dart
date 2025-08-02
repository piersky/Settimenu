import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:settimenu/database/menu_model.dart';
import 'package:settimenu/ui/card_day.dart';
import 'package:settimenu/ui/debug.dart';
import 'package:settimenu/ui/edit_meal.dart';
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
    MenuModel defaultMenu = MenuModel(
      id: 1,
      name: 'Menu 1',
      description: "Default Menu",
      imageUrl: 'https://example.com/image.png',
      isActive: 1,
    );
    await DatabaseHelper.instance.insertMenu(defaultMenu);
    await setDatabaseCreated();
  } else {
    print("MAIN - Database already created");
    // await DatabaseHelper.instance.deleteDatabase();
    // final prefs = await SharedPreferences.getInstance();
    // await prefs.setBool(kDatabaseCreated, false);
  }

  // await DatabaseHelper.instance.deleteDatabase();

  runApp(const Settimenu());
}

class Settimenu extends StatelessWidget {
  const Settimenu({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: const [
        Locale('en', ''), // English
        Locale('it', ''), // Italian
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: const Locale('it'),
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
        EditMealUI.id: (context) {
          final args =
              ModalRoute.of(context)?.settings.arguments
                  as Map<String, dynamic>;
          return EditMealUI(
            daySelected: args['daySelected'] as int,
            mealType: args['mealType'] as String,
          );
        },
        CardDayUI.id: (context) {
          final args =
              ModalRoute.of(context)?.settings.arguments
                  as Map<String, dynamic>;
          return CardDayUI(daySelected: args['daySelected'] as int);
        },
      },
    );
  }
}
