import 'package:brain_game_rapid_fire/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:brain_game_rapid_fire/constants/palette.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = Palette();
    return  Scaffold(
      backgroundColor: palette.background4,
body: SafeArea(
  child: 
  Padding(
    padding: const EdgeInsets.all(16.0),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: 
        [
          //SizedBox(height: 48,),
          SizedBox(height: 280.0,
          child: Image.asset(kArrowSwipeLeftAsset)),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(kSwipeLeft), //TODO : FONT FAMILY AND TEXT STYLE 
            // TODO: LOCalizable string 
            ),
      
        ],),
    ),
  ),
  ),
    );
  }
}