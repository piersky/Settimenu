import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'edit_meal.dart';

class CardDayUI extends StatefulWidget {
  static const String id = 'card_day_ui';
  final int daySelected;

  const CardDayUI({super.key, required this.daySelected});

  @override
  _CardDayUIState createState() => _CardDayUIState();
}

class _CardDayUIState extends State<CardDayUI> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                'Breakfast',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: const Icon(FontAwesomeIcons.pencil),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    EditMealUI.id,
                    arguments: {
                      'daySelected': widget.daySelected,
                      'mealType': 'breakfast',
                    },
                  );
                },
              ),
            ),
          ],
        ),
        Column(
          children: [
            Text('Pancakes'),
            Text('Waffles'),
            Text('french Toast'),
            Text('Omelette'),
            Text('Smoothie'),
          ],
        ),
        Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                'Brunch',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: const Icon(FontAwesomeIcons.pencil),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    EditMealUI.id,
                    arguments: {
                      'daySelected': widget.daySelected,
                      'mealType': 'brunch',
                    },
                  );
                },
              ),
            ),
          ],
        ),
        Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                'Lunch',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: const Icon(FontAwesomeIcons.pencil),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    EditMealUI.id,
                    arguments: {
                      'daySelected': widget.daySelected,
                      'mealType': 'lunch',
                    },
                  );
                },
              ),
            ),
          ],
        ),
        Column(
          children: [
            Text('Pasta'),
            Text('Pizza'),
            Text('Salad'),
            Text('Soup'),
            Text('Sandwich'),
          ],
        ),
        Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                'Dinner',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: const Icon(FontAwesomeIcons.pencil),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    EditMealUI.id,
                    arguments: {
                      'daySelected': widget.daySelected,
                      'mealType': 'dinner',
                    },
                  );
                },
              ),
            ),
          ],
        ),
        Column(
          children: [
            Text('Steak'),
            Text('Fish'),
            Text('Chicken'),
            Text('Vegetables'),
            Text('Rice'),
          ],
        ),
        Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                'Snack',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: const Icon(FontAwesomeIcons.pencil),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    EditMealUI.id,
                    arguments: {
                      'daySelected': widget.daySelected,
                      'mealType': 'snack',
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
