import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('2048 Like'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              // Affiche une boite de dialogue av les informations
              showAboutDialog(
                  context: context,
                  applicationName: '2048 Like',
                  children: [
                    const Text('Un jeu 2048, développé en Flutter par GOULOIS Lukas'),
                  ],
              );
            }
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Coups : 0", // Texte statique temporaire pour le compteur de coups
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
          ),
          Expanded(
            child: Center(
              child: Text(
                "Grille de jeu ici", // Texte statique temporaire pour la grille de jeu
              ),
            ),
          )
        ],
      ),
    );
  }
}

