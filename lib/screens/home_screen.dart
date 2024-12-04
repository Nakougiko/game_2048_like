import 'package:flutter/material.dart';
import 'package:flutter_swipe_detector/flutter_swipe_detector.dart';
import '../widgets/board_painter.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _swipeDirection = ""; // Variable pour afficher la direction

  void _handleSwipe(SwipeDirection direction) {
    setState(() {
      // Déterminer la direction et effectuer des actions
      switch (direction) {
        case SwipeDirection.up:
          _swipeDirection = "Haut";
          break;
        case SwipeDirection.down:
          _swipeDirection = "Bas";
          break;
        case SwipeDirection.left:
          _swipeDirection = "Gauche";
          break;
        case SwipeDirection.right:
          _swipeDirection = "Droite";
          break;
        default:
          _swipeDirection = "";
      }
    });

    // Affiche la direction dans la console (à remplacer par des actions)
    print("Balayage détecté : $_swipeDirection");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('2048 Like'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        titleTextStyle: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Coups : 0", // Temporaire
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Center(
              child: AspectRatio(
                aspectRatio: 1,
                child: SwipeDetector(
                  onSwipeUp: (Offset offset) =>
                      _handleSwipe(SwipeDirection.up),
                  onSwipeDown: (Offset offset) =>
                      _handleSwipe(SwipeDirection.down),
                  onSwipeLeft: (Offset offset) =>
                      _handleSwipe(SwipeDirection.left),
                  onSwipeRight: (Offset offset) =>
                      _handleSwipe(SwipeDirection.right),
                  child: CustomPaint(
                    painter: BoardPainter(
                        [2, 0, 4, 8, 0, 2, 4, 16, 8, 0, 0, 2, 32, 0, 4, 2]),
                    child: Container(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('Nouveau jeu demandé');
        },
        child: const Icon(Icons.refresh),
        tooltip: 'Nouveau jeu',
      ),
    );
  }
}
