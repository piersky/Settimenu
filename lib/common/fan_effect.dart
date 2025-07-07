import 'package:flutter/material.dart';

import '../ui/card_day.dart';
import '../ui/settings.dart';
import '../utils/globals.dart';

class FanEffectScreen extends StatefulWidget {
  const FanEffectScreen({super.key});

  @override
  State<FanEffectScreen> createState() => _FanEffectScreenState();
}

class _FanEffectScreenState extends State<FanEffectScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _animations;
  final int _numCards = 7;
  final double _overlapFactor = 0.9;
  final double _rotationFactor = 0.1;
  late PageController _pageController;
  double _currentPage = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _animations = List.generate(_numCards, (index) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(index / _numCards, 1.0, curve: Curves.easeInOut),
        ),
      );
    });

    _pageController = PageController(viewportFraction: 0.6);
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page ?? 0;
      });
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    const cardWidth = 200.0;
    const cardHeight = 200.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settimenu'),
        backgroundColor: Colors.orangeAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsUI()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            width: screenWidth,
            height: cardHeight * 1.2,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.yellow, Colors.orangeAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: PageView.builder(
                controller: _pageController,
                itemCount: _numCards,
                physics: const ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  return AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      final animationValue = _animations[index].value;
                      final difference = (_currentPage - index).abs();
                      final scale = 1 - difference * 0.2;
                      final opacity = 1 - difference * 0.4;
                      final rotation =
                          (_rotationFactor * (index - _currentPage) * 2);

                      return Transform.scale(
                        scale: scale.clamp(0.8, 1.0),
                        child: Opacity(
                          opacity: animationValue,
                          // opacity: opacity.clamp(0.4, 1.0),
                          child: Transform.rotate(
                            angle: rotation,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10.0,
                                vertical: 20.0,
                              ),
                              child: SizedBox(
                                width: cardWidth,
                                height: cardHeight,
                                child: Card(
                                  elevation: 4,
                                  color:
                                      Colors.primaries[index %
                                          Colors.primaries.length],
                                  child: InkWell(
                                    onTap: () {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Hai tappato la Card ${index + 1}',
                                          ),
                                        ),
                                      );
                                    },
                                    child: Center(
                                      child: Text(
                                        'Card ${index + 1}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "Current Page: ${WeekDays.values[_currentPage.toInt().clamp(0, WeekDays.values.length - 1)]}",
          ),
          const SizedBox(height: 20),
          CardDayUI(daySelected: _currentPage.toInt()),
        ],
      ),
    );
  }
}
