import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiktaktoe/provider/room_data_provider.dart';
import 'package:tiktaktoe/resources/socket_methods.dart';

class TiktaktoeBoard extends StatefulWidget {
  const TiktaktoeBoard({super.key});

  @override
  State<TiktaktoeBoard> createState() => _TiktaktoeBoardState();
}

class _TiktaktoeBoardState extends State<TiktaktoeBoard> {
  final SocketMethods _socketMethods = SocketMethods();
  onGridBoxTap(int index, RoomDataProvider roomDataProvider) {
    _socketMethods.tapGrid(index, roomDataProvider.roomData['id'], roomDataProvider.displayElements);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: size.height * 0.7,
        maxWidth: 500,
      ),
      child: GridView.builder(
        itemCount: 9,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => onGridBoxTap(index, roomDataProvider),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white24),
              ),
              child: const Center(
                child: Text(
                  'X',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 100,
                    shadows: [Shadow(blurRadius: 40, color: Colors.blue)],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}