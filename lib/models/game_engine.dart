import 'package:flutter/material.dart';
import 'dart:math'; // necessary to use Random
import 'package:sensors_plus/sensors_plus.dart'; // shake it move 

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

/// Game Engine 
/// After the game has started , the game logic will take place here 
/// game state, rules, difficulty adjustments, and score calculations.

class GameEngine {
  int score = 0;
  String currentMove = 'Swipe Up';
  double gameSpeed = 1.0;
  bool isGameOver = false;

  // Events for communicating with the UI
  final void Function(String) onNewMove;
  final void Function(int) onScoreUpdate;
  final void Function() onGameOver;

  GameEngine({
    required this.onNewMove,
    required this.onScoreUpdate,
    required this.onGameOver,
  });

  void startGame() {
  score = 0;      // Reset the score
  gameSpeed = 2.0;  // Reset the game speed, in seconds 
  isGameOver = false; // Reset game over state

  onScoreUpdate(score);  // Notify UI to update the score display
    nextMove(); 
  }

  void nextMove() { 
    const List<String> moves = ['Swipe Up', 'Swipe Down', 'Swipe Left', 'Swipe Right'];

    // Introduce "Shake It" after a certain score
    bool addShakeIt = (score >= 10 && moves.length == 4);
    if (addShakeIt) {
      moves.add('Shake It');
    }

    final randomIndex = Random().nextInt(moves.length);
    currentMove = moves[randomIndex];
    onNewMove(currentMove);

    // Increase game speed (adjust the increment as needed)
    if (score > 0 && score % 5 == 0) {
      gameSpeed += 0.1;
    }
  }

  void handleMove(String playerMove) {
    // ... (game logic - update score, check for game over)
  if (playerMove == currentMove) {
      score++;
      onScoreUpdate(score);
      nextMove();
    } else {
      isGameOver = true;
      onGameOver(); // TODO:(Save high score to Firebase, show game over screen) ...
    }

  }
// Firestore methods 
  Future<void> loadHighScore() async {
    // ... (Load from Firestore based on user ID)
  }

  Future<void> saveHighScore() async {
    // ... (Save to Firestore, updating if necessary)
  }




}

// Might need for a timer-> If so, remember to dispose of resources 
// import 'dart:async'; // Import for Timer

// class GameEngine {
//   // ... other properties
//   Timer? _gameTimer;

//   void startGame() {
//     // ... other initialization logic

//     _gameTimer = Timer.periodic(Duration(seconds: 1), (_) {
//       // Update game state every second
//     });
//   }

//   void dispose() {
//     _gameTimer?.cancel(); // Cancel the timer if it's active
//   }
// }






















// class GameBrain extends StatefulWidget {
//   const GameBrain({super.key});

//   @override
//   State<GameBrain> createState() => _GameBrainState();
// }

// class _GameBrainState extends State<GameBrain> {
//     int score = 0;
//   String currentMove = 'Swipe Up'; // Initial move
//   bool isGameOver = false;
//   double gameSpeed = 1.0; // Adjust for difficulty

//  @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Bop It!')),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text('Score: $score', style: TextStyle(fontSize: 24)),
//             SizedBox(height: 50),
//             Text(currentMove, style: TextStyle(fontSize: 36)),
//             // ... (Buttons for swipe directions) ...
//             // ... (Shake detection using sensors_plus) ...
//           ],
//         ),
//       ),
//     );
//   }

// void nextMove() {
//   const List<String> moves = ['Swipe Up', 'Swipe Down', 'Swipe Left', 'Swipe Right'];

//   // Determine if it's time to introduce the "Shake It" move
//   bool addShakeIt = (score >= 10 && moves.length == 4); // Add after a certain score

//   if (addShakeIt) {
//     moves.add('Shake It');
//   }

//   // Choose a random move
//   Random random = Random();
//   int randomIndex = random.nextInt(moves.length);
//   setState(() {
//     currentMove = moves[randomIndex];

//     // Increase game speed (difficulty)
//     if (score > 0 && score % 5 == 0) { // Increase every 5 points
//       gameSpeed += 0.1; // Adjust the increment for your desired difficulty
//     }
//   });
// }


//   void handleMove(String move) {
//     if (move == currentMove) {
//       setState(() {
//         score++;
//         nextMove();
//       });
//     } else {
//       setState(() {
//         isGameOver = true;
//         // TODO:(Save high score to Firebase, show game over screen) ...
//       });
//     }
//   }

//   // TODO:... (Shake detection methods if using) ...
// }