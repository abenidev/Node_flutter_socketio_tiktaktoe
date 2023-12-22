import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:flutter/material.dart';

class SocketClient {
  io.Socket? socket;
  static SocketClient? _instance;

  SocketClient._internal() {
    debugPrint('running socket...');
    socket = io.io('http://192.168.8.188:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket!.connect();
  }

  static SocketClient? get instance {
    _instance ??= SocketClient._internal();
    return _instance;
  }
}
