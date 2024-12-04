import 'package:flutter/material.dart';
import '../widgets/board_painter.dart';
import 'package:flutter_swipe_detector/flutter_swipe_detector.dart';
import '../utils/grid_manager.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late GridManager gridManager;
  bool isRandomGame = false; // Booléen pour vérifier si le jeu est aléatoire
  int randomTileCount = 4; // Nombre de tuiles à placer dans un jeu aléatoire
  int selectedGoal = 2048; // Objectif sélectionné (par défaut 2048)

  @override
  void initState() {
    super.initState();
    gridManager = GridManager(); // Initialiser GridManager
  }

  // Gère les gestes (swipes) et les directions
  void _handleSwipe(SwipeDirection direction) {
    setState(() {
      // Applique le mouvement en fonction de la direction
      switch (direction) {
        case SwipeDirection.up:
          gridManager.move('up');
          break;
        case SwipeDirection.down:
          gridManager.move('down');
          break;
        case SwipeDirection.left:
          gridManager.move('left');
          break;
        case SwipeDirection.right:
          gridManager.move('right');
          break;
        default:
          break;
      }
    });

    // Vérifie l'état du jeu
    if (gridManager.gameWon) {
      _showGameEndDialog("Vous avez gagné !");
    } else if (gridManager.gameOver) {
      _showGameEndDialog("Jeu terminé, plus de mouvements possibles !");
    }
  }

  // Affiche la boîte de dialogue de fin de jeu
  void _showGameEndDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Fin du jeu"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  // Réinitialiser le jeu avec la configuration actuelle
  void _resetGame() {
    setState(() {
      print("Valeur de maVariable : $selectedGoal");
      gridManager.goal = selectedGoal; // Mettre à jour l'objectif
      if (isRandomGame) {
        gridManager.resetRandomGame(randomTileCount); // Réinitialiser le jeu avec tuiles aléatoires
      } else {
        gridManager.resetNormalGame(); // Réinitialiser le jeu normalement
      }
    });
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
              "Coups : ${gridManager.moves}", // Afficher le nombre de coups
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Center(
              child: AspectRatio(
                aspectRatio: 1,
                child: SwipeDetector(
                  onSwipeUp: (Offset offset) => _handleSwipe(SwipeDirection.up),
                  onSwipeDown: (Offset offset) =>
                      _handleSwipe(SwipeDirection.down),
                  onSwipeLeft: (Offset offset) =>
                      _handleSwipe(SwipeDirection.left),
                  onSwipeRight: (Offset offset) =>
                      _handleSwipe(SwipeDirection.right),
                  child: CustomPaint(
                    painter: BoardPainter(gridManager.grid), // Passer la grille du GridManager
                    child: Container(),
                  ),
                ),
              ),
            ),
          ),
          // CheckBoxListTile pour choisir si le jeu est aléatoire ou non
          CheckboxListTile(
            title: const Text("Grille Aléatoire"),
            value: isRandomGame,
            onChanged: (bool? value) {
              setState(() {
                isRandomGame = value!;
              });
            },
          ),
          // Slider pour ajuster le nombre de tuiles à placer dans le jeu aléatoire
          if (isRandomGame)
            Slider(
              min: 1,
              max: 10,
              divisions: 9,
              value: randomTileCount.toDouble(),
              onChanged: (value) {
                setState(() {
                  randomTileCount = value.toInt();
                });
              },
              label: "$randomTileCount tuiles",
            ),
          // DropdownButton pour sélectionner l'objectif
          DropdownButton<int>(
            value: selectedGoal,
            items: [256, 512, 1024, 2048, 4096]
                .map((goal) => DropdownMenuItem<int>(
              value: goal,
              child: Text('Atteindre $goal'),
            ))
                .toList(),
            onChanged: (value) {
              setState(() {
                selectedGoal = value!;
              });
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _resetGame, // Réinitialiser le jeu avec les nouveaux paramètres
        child: const Icon(Icons.refresh),
        tooltip: 'Nouveau jeu',
      ),
    );
  }
}
