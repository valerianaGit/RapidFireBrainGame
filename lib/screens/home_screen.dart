import 'package:flutter/material.dart';
import '../constants/strings.dart';
import '../constants/palette.dart';
import '../models/game_engine.dart';
import '../widgets/swipe_detector.dart';
import '../widgets/shake_detector.dart';

class HomeScreen extends StatefulWidget {
 
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late GameEngine _gameEngine;
    Color currentColor = Colors.blue; // Initial color

  final Map<SwipeDirection, Color> directionColors = {
    SwipeDirection.up: Colors.green,
    SwipeDirection.down: Colors.red,
    SwipeDirection.left: Colors.yellow,
    SwipeDirection.right: Colors.purple,
  };

  @override
  void initState() {
    super.initState();
    _gameEngine = GameEngine(
      onNewMove: (move) {
//TODO:ERASE => setState(() => _gameEngine.currentMove = move),
          // Update the color based on the new move's direction
          currentColor = directionColors[stringToSwipeDirection(move)]!;
      },
      onScoreUpdate: (newScore) => setState(() => _gameEngine.score = newScore),
      onGameOver: () => showGameOverDialog(),
    );
    _gameEngine.startGame();
  }

  @override
  void dispose() {
    // Clean up game engine resources when the widget is disposed
    // create dispose [IN GAME ENGINE TO BE USED HERE)
    // when we implement timers, etc to avoid memory leaks
    //_gameEngine.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final palette = Palette();
    return Scaffold(
      backgroundColor: palette.background4,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Score: ${_gameEngine.score}',// TODO: LOCALIZABLE STRING 
                    style: const TextStyle(fontSize: 24)),
//SWIPE/shake detection stack
Stack( // Use a Stack to overlay the ShakeDetector
        children: [
          SwipeDetector(
            onSwipe: (direction) {
              _gameEngine.handleMove(direction.toString().split('.').last);
            },
            currentColor: currentColor,
            currentMove: _gameEngine.currentMove,
            child: Container( // The swipeable container
              // ... your container configuration ...
            ),
          ),
          ShakeDetector(
            onShake: () {
              _gameEngine.handleMove('Shake It'); //TODO: LOCALIZABLE STRING
            },
          ),
        ],
      ), 
                SizedBox(
                    height: 280.0, child: Image.asset(kArrowSwipeLeftAsset)),
                 Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(_gameEngine.currentMove,
                      style: const TextStyle(
                          fontSize:
                              36)), 
                              //Text(kSwipeLeft), //TODO : FONT FAMILY AND TEXT STYLE
                  // TODO: LOCalizable string
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showGameOverDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Game Over!'), //TODO: LOCALIZED TEXT
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
                'Your final score is: ${_gameEngine.score}'), //TODO: LOCALIZED TEXT
//TODO: SHOW HIGH SCORE - Keep track of it
            // if (_gameEngine.score > highScore) // Check for new high score
            //   const Text('New High Score!'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
              _gameEngine.startGame(); // Start a new game
            },
            child: const Text('Play Again'), //TODO: LOCALIZED TEXT
          ),
        ],
      ),
    );
  }
    // Helper function to convert string to SwipeDirection
  SwipeDirection stringToSwipeDirection(String move) {
    switch (move) {
      case 'Swipe Up':
        return SwipeDirection.up;
      case 'Swipe Down':
        return SwipeDirection.down;
      case 'Swipe Left':
        return SwipeDirection.left;
      case 'Swipe Right':
        return SwipeDirection.right;
      default:
        return SwipeDirection.up; // Default to up if move is invalid
    }
  }
}
