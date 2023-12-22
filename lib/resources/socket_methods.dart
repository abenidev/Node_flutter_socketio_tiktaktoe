import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiktaktoe/provider/room_data_provider.dart';
import 'package:tiktaktoe/resources/socket_client.dart';
import 'package:tiktaktoe/screens/game_screen.dart';

class SocketMethods {
  final _socketClient = SocketClient.instance!.socket!;

  //EMITS

  //create room
  void createRoom(String nickName) {
    if (nickName.isNotEmpty) {
      _socketClient.emit('createRoom', {
        'nickName': nickName,
      });
    }
  }

  //Join room
  void joinRoom(String nickName, String roomId) {
    if (nickName.isNotEmpty && roomId.isNotEmpty) {
      _socketClient.emit("joinRoom", {
        "nickName": nickName,
        "roomId": roomId,
      });
    }
  }

  //Listeners
  void createRoomSuccessListener(BuildContext context) {
    _socketClient.on("createRoom:success", (room) {
      debugPrint('room: ${room}');
      Provider.of<RoomDataProvider>(context, listen: false).updateRoomData(room);
      Navigator.pushNamed(context, GameScreen.routeName);
    });
  }
}
