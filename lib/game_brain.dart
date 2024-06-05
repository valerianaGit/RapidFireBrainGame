import 'package:flutter/material.dart';
import 'dart:math'; // necessary to use Random

class GameBrain extends StatefulWidget {
  const GameBrain({super.key});

  @override
  State<GameBrain> createState() => _GameBrainState();
}

class _GameBrainState extends State<GameBrain> {
    int score = 0;
  String currentMove = 'Swipe Up'; // Initial move
  bool isGameOver = false;
  double gameSpeed = 1.0; // Adjust for difficulty

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bop It!')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Score: $score', style: TextStyle(fontSize: 24)),
            SizedBox(height: 50),
            Text(currentMove, style: TextStyle(fontSize: 36)),
            // ... (Buttons for swipe directions) ...
            // ... (Shake detection using sensors_plus) ...
          ],
        ),
      ),
    );
  }

void nextMove() {
  const List<String> moves = ['Swipe Up', 'Swipe Down', 'Swipe Left', 'Swipe Right'];

  // Determine if it's time to introduce the "Shake It" move
  bool addShakeIt = (score >= 10 && moves.length == 4); // Add after a certain score

  if (addShakeIt) {
    moves.add('Shake It');
  }

  // Choose a random move
  Random random = Random();
  int randomIndex = random.nextInt(moves.length);
  setState(() {
    currentMove = moves[randomIndex];

    // Increase game speed (difficulty)
    if (score > 0 && score % 5 == 0) { // Increase every 5 points
      gameSpeed += 0.1; // Adjust the increment for your desired difficulty
    }
  });
}


  void handleMove(String move) {
    if (move == currentMove) {
      setState(() {
        score++;
        nextMove();
      });
    } else {
      setState(() {
        isGameOver = true;
        // TODO:(Save high score to Firebase, show game over screen) ...
      });
    }
  }

  // TODO:... (Shake detection methods if using) ...
}