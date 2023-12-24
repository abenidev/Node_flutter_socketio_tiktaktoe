import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tiktaktoe/components/custom_button.dart';
import 'package:tiktaktoe/responsive/responsive.dart';
import 'package:tiktaktoe/screens/create_room_screen.dart';
import 'package:tiktaktoe/screens/join_room_screen.dart';

class MainMenuScreen extends StatelessWidget {
  static String routeName = '/main-menu';
  const MainMenuScreen({super.key});

  void createRoom(BuildContext context) {
    Navigator.pushNamed(context, CreateRoomScreen.routeName);
  }

  void joinRoom(BuildContext context) {
    Navigator.pushNamed(context, JoinRoomScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Lottie.asset('assets/tiktaktoe.json'),
              const SizedBox(height: 10),
              CustomButton(
                ontap: () => createRoom(context),
                label: 'Create Game',
              ),
              const SizedBox(height: 20),
              CustomButton(
                ontap: () => joinRoom(context),
                label: 'Join Game',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
