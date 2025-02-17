import 'package:flutter/material.dart';

class RoomPage extends StatelessWidget {
  final String roomName;
  final String roomCode;
  
  RoomPage({required this.roomName, required this.roomCode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Room: $roomName")),
      body: WillPopScope(
        onWillPop: () async => true,
        child: Center(
          child: Text("Welcome to $roomName (Code: $roomCode)"),
        ),
      ),
    );
  }
}
