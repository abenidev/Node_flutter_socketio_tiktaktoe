import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:tiktaktoe/provider/room_data_provider.dart';
import 'package:tiktaktoe/resources/game_methods.dart';
import 'package:tiktaktoe/resources/socket_client.dart';
import 'package:tiktaktoe/screens/game_screen.dart';
import 'package:tiktaktoe/utils/utils.dart';

class SocketMethods {
  final _socketClient = SocketClient.instance!.socket!;

  Socket get socketClient => _socketClient;

  //!EMITS
  //*Room Emits
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

  //*Player Emits

  //*Game Emits
  void tapGrid(int index, int roomId, List<String> displayElements) {
    if (displayElements[index].isEmpty) {
      _socketClient.emit('tap', {
        'index': index,
        'roomId': roomId,
      });
    }
  }

  void tappedListener(BuildContext context) {
    _socketClient.on("tapped", (data) {
      RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context, listen: false);
      roomDataProvider.updateDisplayElements(data['index'], data['choice']);
      roomDataProvider.updateRoomData(data['updatedRoom']);
      //check game winner
      GameMethods().checkWinnder(context, socketClient);
    });
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

  //*Game listeners
  void pointIncreaseListener(BuildContext context) {
    _socketClient.on('pointIncrease', (playerData) {
      RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context, listen: false);
      if (playerData['socketId'] == roomDataProvider.player1.socketId) {
        roomDataProvider.updatePlayer1(playerData);
      } else {
        roomDataProvider.updatePlayer2(playerData);
      }
    });
  }

  void endGameListener(BuildContext context) {
    _socketClient.on("endGame", (playerData) {
      showGameDialog(context, '${playerData['nickName']} won the game!');
      Navigator.popUntil(context, (route) => false);
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
    _socketClient.on("joinRoom:Error:RoomFull", (roomData) {
      debugPrint('joinRoom:Error:RoomFull: $roomData');
      showSnackBar(context, 'Room full. joining as spectator.');
      Provider.of<RoomDataProvider>(context, listen: false).updateRoomData(roomData);
      Navigator.pushNamed(context, GameScreen.routeName);
    });
  }

  //Player Errors
}
