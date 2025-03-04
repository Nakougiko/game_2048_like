# 2048-Like Game

## 📌 Description
Ce projet est une version personnalisée du jeu **2048**, développée en **Flutter**. Il a été conçu pour expérimenter avec **l'interface utilisateur (UI)**, **l'expérience utilisateur (UX)** et la **logique de jeu**.

## 🛠️ Technologies utilisées
- **Flutter** (framework mobile)
- **Dart** (langage de programmation)
- **Provider** (gestion d'état)
- **CustomPainter** (rendu graphique du plateau de jeu)

## 📂 Structure du projet

```
lib/
├── main.dart
├── screens/
│   └── home_screen.dart
├── widgets/
│   ├── board_painter.dart
│   ├── tile_widget.dart
├── models/
│   ├── tile.dart
│   ├── board.dart
├── utils/
│   ├── game_logic.dart
│   ├── constants.dart
assets/
docs/
test/
```

## 🚀 Installation

1. **Cloner le dépôt** :
   ```sh
   git clone https://github.com/Nakougiko/game_2048_like.git
   cd game_2048_like
   ```

2. **Installer les dépendances** :
   ```sh
   flutter pub get
   ```

3. **Lancer l'application** :
   ```sh
   flutter run
   ```
   Assurez-vous d'avoir un **émulateur** ou un **appareil physique connecté**.

## 📌 Fonctionnalités principales

### 🎮 Gameplay
- Déplacement des tuiles avec **glisser/déposer**.
- Fusion des tuiles avec le même nombre.
- Calcul et affichage du score.
- Réinitialisation du jeu.

### 🎨 Interface personnalisée
- Design épuré inspiré de **2048**.
- Palette de couleurs dynamiques pour les différentes valeurs de tuiles.

### 🧠 Moteur de jeu
- Génération aléatoire des nouvelles tuiles.
- Vérification des mouvements possibles.
- Gestion des états (victoire/défaite).

## 🖼️ Aperçu
![image](https://github.com/user-attachments/assets/0619ac72-dad2-43b1-a9c0-cfc361942746)

## 📝 To-Do / Améliorations possibles
- ✅ Déplacement des tuiles
- ✅ Gestion des fusions et du score
- ✅ Interface utilisateur responsive
- 🔲 Ajout d'un mode **sombre**
- 🔲 Implémentation d'un **mode multijoueur**
- 🔲 Sauvegarde des parties en cours
- 🔲 Effets sonores et musiques

## 📜 Licence
Ce projet est sous licence MIT.

## ✉️ Contact
Si vous avez des questions ou des suggestions, vous pouvez me contacter via **[GitHub](https://github.com/Nakougiko)**.
