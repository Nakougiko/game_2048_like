import 'package:flutter/material.dart';

class BoardPainter extends CustomPainter {
  final List<int> values; // Liste des valeurs des cellules

  BoardPainter(this.values);

  @override
  void paint(Canvas canvas, Size size) {
    // Peinture pour le fond
    Paint backgroundPaint = Paint()..color = Colors.grey[300]!;
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      backgroundPaint,
    );

    // Taille de chaque cellule
    double cellSize = size.width / 4;

    // Peinture pour les lignes de la grille
    Paint linePaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 4.0;

    // Dessine les lignes verticales et horizontales
    for (int i = 1; i < 4; i++) {
      // Lignes verticales
      canvas.drawLine(
        Offset(cellSize * i, 0),
        Offset(cellSize * i, size.height),
        linePaint,
      );
      // Lignes horizontales
      canvas.drawLine(
        Offset(0, cellSize * i),
        Offset(size.width, cellSize * i),
        linePaint,
      );
    }

    // Dessine les cellules
    for (int row = 0; row < 4; row++) {
      for (int col = 0; col < 4; col++) {
        int index = row * 4 + col;
        int value = values[index];

        // Couleur basée sur bitLength
        Paint cellPaint = Paint()
          ..color = value == 0
              ? Colors.white
              : Colors.purple[100 * (value.bitLength - 1)] ?? Colors.purple;

        // Position et taille de la cellule
        double left = col * cellSize;
        double top = row * cellSize;
        canvas.drawRect(
          Rect.fromLTWH(left, top, cellSize, cellSize),
          cellPaint,
        );

        // Texte de la valeur
        if (value != 0) {
          final textPainter = TextPainter(
            text: TextSpan(
              text: '$value',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            textDirection: TextDirection.ltr,
          );
          textPainter.layout();
          textPainter.paint(
            canvas,
            Offset(
              left + (cellSize - textPainter.width) / 2,
              top + (cellSize - textPainter.height) / 2,
            ),
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // Redessine si les valeurs changent
    return true;
  }
}
