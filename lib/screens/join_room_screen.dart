import 'package:flutter/material.dart';
import 'package:tiktaktoe/components/custom_button.dart';
import 'package:tiktaktoe/components/custom_text.dart';
import 'package:tiktaktoe/components/custom_textfield.dart';
import 'package:tiktaktoe/resources/socket_methods.dart';
import 'package:tiktaktoe/responsive/responsive.dart';

class JoinRoomScreen extends StatefulWidget {
  static String routeName = '/join-room';
  const JoinRoomScreen({super.key});

  @override
  State<JoinRoomScreen> createState() => _JoinRoomScreenState();
}

class _JoinRoomScreenState extends State<JoinRoomScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _gameIdController;
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _gameIdController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _gameIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Responsive(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CustomText(
                text: 'Join Room',
                fontSize: 70,
                shadows: [Shadow(blurRadius: 40, color: Colors.blue)],
              ),
              SizedBox(height: size.height * 0.08),
              CustomTextField(
                controller: _nameController,
                hintText: "Enter your name",
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: _gameIdController,
                hintText: "Enter Game Id",
              ),
              SizedBox(height: size.height * 0.045),
              CustomButton(
                ontap: () {
                  _socketMethods.joinRoom(_nameController.text.trim(), _gameIdController.text.trim());
                },
                label: "Join",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
