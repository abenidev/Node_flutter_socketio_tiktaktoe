import 'package:flutter/material.dart';
import 'package:tiktaktoe/components/custom_button.dart';
import 'package:tiktaktoe/components/custom_text.dart';
import 'package:tiktaktoe/components/custom_textfield.dart';
import 'package:tiktaktoe/resources/socket_methods.dart';
import 'package:tiktaktoe/responsive/responsive.dart';

class CreateRoomScreen extends StatefulWidget {
  static String routeName = '/create-room';

  const CreateRoomScreen({super.key});

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  late final TextEditingController _nameController;
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    _socketMethods.createRoomSuccessListener(context);
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
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
                text: 'Create Room',
                fontSize: 70,
                shadows: [Shadow(blurRadius: 40, color: Colors.blue)],
              ),
              SizedBox(height: size.height * 0.08),
              CustomTextField(
                controller: _nameController,
                hintText: "Enter your name",
              ),
              SizedBox(height: size.height * 0.045),
              CustomButton(
                ontap: () {
                  if (_nameController.text.trim().isNotEmpty) {
                    _socketMethods.createRoom(_nameController.text.trim());
                  }
                },
                label: "Create",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
