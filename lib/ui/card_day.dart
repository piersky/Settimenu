import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    return Column(
      children: [
        Text('Breakfast', style: Theme.of(context).textTheme.headlineLarge),
        Column(
          children: [
            Text('Pancakes'),
            Text('Waffles'),
            Text('french Toast'),
            Text('Omelette'),
            Text('Smoothie'),
          ],
        ),
        Text('Launch', style: Theme.of(context).textTheme.headlineLarge),
        Column(
          children: [
            Text('Pasta'),
            Text('Pizza'),
            Text('Salad'),
            Text('Soup'),
            Text('Sandwich'),
          ],
        ),
        Text('Dinner', style: Theme.of(context).textTheme.headlineLarge),
        Column(
          children: [
            Text('Steak'),
            Text('Fish'),
            Text('Chicken'),
            Text('Vegetables'),
            Text('Rice'),
          ],
        ),
      ],
    );
  }
}
