import 'package:flutter/material.dart';
import 'constants/strings.dart';
import 'screens/home_screen.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
     SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    return MaterialApp(
        title: kAppTitle, // TODO: LOCalizable string 
        theme: ThemeData(
          primarySwatch: Colors.green, //TODO: CREATE THE THEME COLORS - COLOR PALETTE 
        ),
        home: const HomeScreen(),
      );
     // dispose: (context, db) => db.close(), 
     //// dispose is a method from provider, 
     /////find out how to use riverpod   -> https://riverpod.dev/docs/concepts/modifiers/auto_dispose, autodispose right in the provider 
  }
}

// Movements 
  // Shake it 
  // Tilt it 
      // left / right 
  // Swipe 
      // left / right 
      // up / down 
// Each movement will have 
// asset , title , sound , color 

// To get harder, the background color shuffles, and is not connected to the specific movement anymore 

//TODO: Create package dependencies - auth firebase, sensors _plus 