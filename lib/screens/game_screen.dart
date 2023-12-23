import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiktaktoe/components/score_board.dart';
import 'package:tiktaktoe/components/tiktaktoe_board.dart';
import 'package:tiktaktoe/components/waiting_lobby.dart';
import 'package:tiktaktoe/provider/room_data_provider.dart';
import 'package:tiktaktoe/resources/socket_methods.dart';

class GameScreen extends StatefulWidget {
  static String routeName = '/game';
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    _socketMethods.updateRoomListener(context);
    _socketMethods.updatePlayersListener(context);
    _socketMethods.pointIncreaseListener(context);
    _socketMethods.endGameListener(context);
  }

  @override
  Widget build(BuildContext context) {
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);

    return Scaffold(
      body: roomDataProvider.roomData['isJoin']
          ? const WaitingLobby()
          : SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const ScoreBoard(),
                  const TiktaktoeBoard(),
                  Text('${roomDataProvider.getTurnPlayer()?.nickName}\'s turn'),
                ],
              ),
            ),
    );
  }
}
