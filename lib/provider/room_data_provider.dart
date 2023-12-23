import 'package:flutter/material.dart';
import 'package:tiktaktoe/models/player.dart';
import 'package:tiktaktoe/resources/socket_methods.dart';

class RoomDataProvider extends ChangeNotifier {
  Map<String, dynamic> _roomData = {};
  final List<String> _displayElements = ['', '', '', '', '', '', '', '', ''];
  int _filledBoxes = 0;
  Player _player1 = Player(id: 0, nickName: '', socketId: '', points: 0, playerType: 'X');
  Player _player2 = Player(id: 0, nickName: '', socketId: '', points: 0, playerType: 'O');

  Map<String, dynamic> get roomData => _roomData;
  Player get player1 => _player1;
  Player get player2 => _player2;
  List<String> get displayElements => _displayElements;
  int get filledBoxes => _filledBoxes;

  void setFilledBoxesTo0() {
    _filledBoxes = 0;
    notifyListeners();
  }

  void updateRoomData(Map<String, dynamic> roomData) {
    _roomData = roomData;
    notifyListeners();
  }

  void updatePlayer1(Map<String, dynamic> player1Data) {
    _player1 = Player.fromMap(player1Data);
    notifyListeners();
  }

  void updatePlayer2(Map<String, dynamic> player2Data) {
    _player2 = Player.fromMap(player2Data);
    notifyListeners();
  }

  void updateDisplayElements(int index, String choice) {
    _displayElements[index] = choice;
    _filledBoxes += 1;
    notifyListeners();
  }

  Player? getMyPlayerData() {
    final socketMethods = SocketMethods();
    String? socketId = socketMethods.socketClient.id;
    if (socketId != null) {
      if (player1.socketId == socketId) {
        return player1;
      }
      if (player2.socketId == socketId) {
        return player2;
      }
    }

    return null;
  }

  Player? getTurnPlayer() {
    int turn = roomData['turn'];
    if (player1.id == turn) {
      return player1;
    }
    if (player2.id == turn) {
      return player2;
    }

    return null;
  }
}
