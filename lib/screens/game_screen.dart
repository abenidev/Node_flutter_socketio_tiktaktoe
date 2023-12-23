import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiktaktoe/models/player.dart';
import 'package:tiktaktoe/provider/room_data_provider.dart';

class GameScreen extends StatefulWidget {
  static String routeName = '/game';
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    var roomD = Provider.of<RoomDataProvider>(context).roomData.toString();
    Player player1 = Provider.of<RoomDataProvider>(context).player1;
    Player player2 = Provider.of<RoomDataProvider>(context).player2;
    debugPrint('player1: ${player1.toString()} || player2: ${player2.toString()}');

    return Scaffold(
      body: Center(
        child: Text(roomD),
      ),
    );
  }
}
