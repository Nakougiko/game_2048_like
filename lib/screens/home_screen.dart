import 'package:flutter/material.dart';
import '../widgets/board_painter.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold pour la structure de la page
      appBar: AppBar(
        title: const Text('2048 Like'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        titleTextStyle: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            color: Colors.white,
            onPressed: () {
              // Affiche une boite de dialogue avec les informations
              showAboutDialog(
                context: context,
                applicationName: '2048 Like',
                children: [
                  const Text(
                      'Un jeu 2048, développé en Flutter par GOULOIS Lukas'),
                ],
              );
            },
          ),
        ],
      ),
      body: Column(
        // Corps de la page
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Coups : 0", // Texte statique temporaire pour le compteur de coups
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            // Permet au widget enfant de prendre toute la place disponible
            child: Center(
              child: AspectRatio(
                aspectRatio: 1,
                child: CustomPaint(
                  painter: BoardPainter([
                    2,
                    0,
                    4,
                    8,
                    0,
                    2,
                    4,
                    16,
                    8,
                    0,
                    0,
                    2,
                    32,
                    0,
                    4,
                    2
                  ]), // Valeur fictive
                  child: Container(),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Fonction vide pour l'instant
          print('Nouveau jeu demandé');
        },
        child: const Icon(Icons.refresh),
        tooltip: 'Nouveau jeu',
      ),
    );
  }
}
