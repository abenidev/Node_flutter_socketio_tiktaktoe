import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiktaktoe/components/custom_textfield.dart';
import 'package:tiktaktoe/provider/room_data_provider.dart';

class WaitingLobby extends StatefulWidget {
  const WaitingLobby({super.key});

  @override
  State<WaitingLobby> createState() => _WaitingLobbyState();
}

class _WaitingLobbyState extends State<WaitingLobby> {
  late final TextEditingController _roomIdController;
  @override
  void initState() {
    super.initState();
    _roomIdController = TextEditingController(
      text: Provider.of<RoomDataProvider>(context, listen: false).roomData['id'].toString(),
    );
  }

  @override
  void dispose() {
    _roomIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Waiting for a player to join'),
        const SizedBox(height: 20),
        CustomTextField(
          controller: _roomIdController,
          isReadOnly: true,
          hintText: '',
        ),
      ],
    );
  }
}
