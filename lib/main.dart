import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tiktaktoe/provider/room_data_provider.dart';
import 'package:tiktaktoe/screens/create_room_screen.dart';
import 'package:tiktaktoe/screens/game_screen.dart';
import 'package:tiktaktoe/screens/join_room_screen.dart';
import 'package:tiktaktoe/screens/main_menu_screen.dart';
import 'package:tiktaktoe/utils/colors.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: bgColor, statusBarIconBrightness: Brightness.dark, statusBarBrightness: Brightness.dark),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RoomDataProvider(),
      child: MaterialApp(
        title: 'Titktaktoe',
        theme: ThemeData.light().copyWith(scaffoldBackgroundColor: bgColor),
        routes: {
          MainMenuScreen.routeName: (context) => const MainMenuScreen(),
          CreateRoomScreen.routeName: (context) => const CreateRoomScreen(),
          JoinRoomScreen.routeName: (context) => const JoinRoomScreen(),
          GameScreen.routeName: (context) => const GameScreen(),
        },
        initialRoute: MainMenuScreen.routeName,
      ),
    );
  }
}
