// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Player {
  final int id;
  final String nickName;
  final String socketId;
  final int points;
  final String playerType;
  Player({
    required this.id,
    required this.nickName,
    required this.socketId,
    required this.points,
    required this.playerType,
  });

  Player copyWith({
    int? id,
    String? nickName,
    String? socketId,
    int? points,
    String? playerType,
  }) {
    return Player(
      id: id ?? this.id,
      nickName: nickName ?? this.nickName,
      socketId: socketId ?? this.socketId,
      points: points ?? this.points,
      playerType: playerType ?? this.playerType,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nickName': nickName,
      'socketId': socketId,
      'points': points,
      'playerType': playerType,
    };
  }

  factory Player.fromMap(Map<String, dynamic> map) {
    return Player(
      id: map['id'] as int,
      nickName: map['nickName'] as String,
      socketId: map['socketId'] as String,
      points: map['points'] as int,
      playerType: map['playerType'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Player.fromJson(String source) => Player.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Player(id: $id, nickName: $nickName, socketId: $socketId, points: $points, playerType: $playerType)';
  }

  @override
  bool operator ==(covariant Player other) {
    if (identical(this, other)) return true;

    return other.id == id && other.nickName == nickName && other.socketId == socketId && other.points == points && other.playerType == playerType;
  }

  @override
  int get hashCode {
    return id.hashCode ^ nickName.hashCode ^ socketId.hashCode ^ points.hashCode ^ playerType.hashCode;
  }
}
