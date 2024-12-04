import 'dart:math';
import 'package:collection/collection.dart';

class GridManager {
  List<int> grid = List.filled(16, 0); // Grille initiale
  bool gameWon = false;  // Indicateur de victoire
  bool gameOver = false; // Indicateur de défaite
  int goal = 2048; // Objectif du jeu
  bool isRandomGame = false; // Si la grille est aléatoire
  int randomTileCount = 4; // Nombre de tuiles à placer dans un jeu aléatoire
  int moves = 0; // Nombre de coups

  GridManager() {
    resetNormalGame(); // Initialiser avec un jeu normal
  }

  // Applique les nouveaux paramètres sans redémarrer
  void applyNewSettings() {
    if (isRandomGame) {
      resetRandomGame(randomTileCount);
    } else {
      resetNormalGame();
    }
  }

  // Réinitialiser le jeu normalement
  void resetNormalGame() {
    grid = List.filled(16, 0);
    _addRandomTile();
    _addRandomTile();
    gameWon = false;
    gameOver = false;
    moves = 0;
  }

  // Réinitialiser le jeu avec des tuiles aléatoires
  void resetRandomGame(int tileCount) {
    grid = List.filled(16, 0);
    for (int i = 0; i < tileCount; i++) {
      _addRandomTile();
    }
    gameWon = false;
    gameOver = false;
    moves = 0;
  }

  // Ajoute une tuile aléatoire (2 ou 4)
  void _addRandomTile() {
    List<int> emptyCells = [];
    for (int i = 0; i < grid.length; i++) {
      if (grid[i] == 0) emptyCells.add(i);
    }

    if (emptyCells.isNotEmpty) {
      int randomIndex = emptyCells[Random().nextInt(emptyCells.length)];
      grid[randomIndex] = Random().nextDouble() < 0.9 ? 2 : 4;
    }
  }

  // Fonction principale pour déplacer et fusionner les tuiles
  bool move(String direction) {
    if (gameWon || gameOver) {
      return false; // Si le jeu est terminé, ne faire aucun mouvement
    }

    List<int> oldGrid = List.from(grid);

    switch (direction) {
      case 'up':
        _moveUp();
        break;
      case 'down':
        _moveDown();
        break;
      case 'left':
        _moveLeft();
        break;
      case 'right':
        _moveRight();
        break;
    }

    if (!ListEquality().equals(grid, oldGrid)) {
      _addRandomTile(); // Ajouter une nouvelle tuile
    }

    // Vérifie si le jeu est gagné ou perdu
    _checkGameStatus();

    return true;
  }

  // Déplace les cases vers le haut
  void _moveUp() {
    for (int col = 0; col < 4; col++) {
      List<int> column = [];
      for (int row = 0; row < 4; row++) {
        column.add(grid[row * 4 + col]);
      }
      column = _merge(_compress(column));
      for (int row = 0; row < 4; row++) {
        grid[row * 4 + col] = column[row];
      }
    }
  }

  // Déplace les cases vers le bas
  void _moveDown() {
    for (int col = 0; col < 4; col++) {
      List<int> column = [];
      for (int row = 0; row < 4; row++) {
        column.add(grid[row * 4 + col]);
      }
      column = _merge(_compress(column.reversed.toList())).reversed.toList();
      for (int row = 0; row < 4; row++) {
        grid[row * 4 + col] = column[row];
      }
    }
  }

  // Déplace les cases vers la gauche
  void _moveLeft() {
    for (int row = 0; row < 4; row++) {
      List<int> line = grid.sublist(row * 4, (row + 1) * 4);
      line = _merge(_compress(line));
      for (int col = 0; col < 4; col++) {
        grid[row * 4 + col] = line[col];
      }
    }
  }

  // Déplace les cases vers la droite
  void _moveRight() {
    for (int row = 0; row < 4; row++) {
      List<int> line = grid.sublist(row * 4, (row + 1) * 4);
      line = _merge(_compress(line.reversed.toList())).reversed.toList();
      for (int col = 0; col < 4; col++) {
        grid[row * 4 + col] = line[col];
      }
    }
  }

  // Compresse les cellules (élimine les zéros)
  List<int> _compress(List<int> line) {
    List<int> compressed = line.where((value) => value != 0).toList();
    while (compressed.length < 4) {
      compressed.add(0);
    }
    return compressed;
  }

  // Fusionne les cellules adjacentes identiques
  List<int> _merge(List<int> line) {
    for (int i = 0; i < line.length - 1; i++) {
      if (line[i] != 0 && line[i] == line[i + 1]) {
        line[i] *= 2;
        line[i + 1] = 0;
      }
    }
    return _compress(line);
  }

  // Vérifie si le jeu est gagné ou perdu
  void _checkGameStatus() {
    // Vérifie la condition de victoire
    if (grid.contains(goal)) {
      gameWon = true;
    }

    // Vérifie si le jeu est perdu (plus de mouvements possibles)
    if (!_hasValidMoves()) {
      gameOver = true;
    }
  }

  // Vérifie s'il reste des mouvements possibles
  bool _hasValidMoves() {
    // Vérifie s'il y a des cases vides
    if (grid.contains(0)) return true;

    // Vérifie les possibilités de fusion (horizontalement et verticalement)
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 3; j++) {
        // Vérifie horizontalement
        if (grid[i * 4 + j] == grid[i * 4 + j + 1]) return true;
        // Vérifie verticalement
        if (grid[j * 4 + i] == grid[(j + 1) * 4 + i]) return true;
      }
    }

    return false; // Aucune fusion possible
  }
}
