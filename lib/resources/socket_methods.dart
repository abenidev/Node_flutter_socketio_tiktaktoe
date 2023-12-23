import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiktaktoe/provider/room_data_provider.dart';
import 'package:tiktaktoe/resources/socket_client.dart';
import 'package:tiktaktoe/screens/game_screen.dart';
import 'package:tiktaktoe/utils/utils.dart';

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
        "roomId": int.parse(roomId),
      });
    }
  }

  //!Listeners
  //*Room listeners
  void createRoomSuccessListener(BuildContext context) {
    _socketClient.on("createRoom:success", (room) {
      debugPrint('room: ${room}');
      Provider.of<RoomDataProvider>(context, listen: false).updateRoomData(room);
      Navigator.pushNamed(context, GameScreen.routeName);
    });
  }

  void joinRoomSuccessListener(BuildContext context) {
    _socketClient.on("joinRoom:success", (room) {
      debugPrint('room: ${room}');
      Provider.of<RoomDataProvider>(context, listen: false).updateRoomData(room);
      Navigator.pushNamed(context, GameScreen.routeName);
    });
  }

  void updateRoomListener(BuildContext context) {
    _socketClient.on("updateRoom", (room) {
      Provider.of<RoomDataProvider>(context, listen: false).updateRoomData(room);
    });
  }

  //*Player Listeners
  void updatePlayersListener(BuildContext context) {
    _socketClient.on("updatePlayers", (players) {
      Provider.of<RoomDataProvider>(context, listen: false).updatePlayer1(players[0]);
      Provider.of<RoomDataProvider>(context, listen: false).updatePlayer2(players[1]);
    });
  }

  //!Error listener
  //Room errors
  void joinRoomInvalidRoomErrorListener(BuildContext context) {
    _socketClient.on("joinRoom:Error:InvalidRoomId", (error) {
      debugPrint('joinRoom:Error:InvalidRoomId: $error');
      showSnackBar(context, error);
    });
  }

  void joinRoomRoomFullErrorListener(BuildContext context) {
    _socketClient.on("joinRoom:Error:RoomFull", (error) {
      debugPrint('joinRoom:Error:RoomFull: $error');
      showSnackBar(context, error);
    });
  }
}
