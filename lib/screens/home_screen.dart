import 'package:brain_game_rapid_fire/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:brain_game_rapid_fire/constants/palette.dart';
import 'package:brain_game_rapid_fire/models/game_engine.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late GameEngine _gameEngine;

  @override
  void initState() {
    super.initState();
    _gameEngine = GameEngine(
      onNewMove: (move) => setState(() => _gameEngine.currentMove = move),
      onScoreUpdate: (newScore) => setState(() => _gameEngine.score = newScore),
      onGameOver: () => showGameOverDialog(),
    );
    _gameEngine.startGame();
  }

  @override
  void dispose() {
    // Clean up game engine resources when the widget is disposed
    // create dispose when we implement timers, etc to avoid memory leaks
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
              //TODO: action button so person can respond  
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
}
