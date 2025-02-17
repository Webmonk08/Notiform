import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'room_page.dart';

class JoinRoomPage extends StatefulWidget {
  const JoinRoomPage({Key? key}) : super(key: key);

  @override
  _JoinRoomPageState createState() => _JoinRoomPageState();
}

class _JoinRoomPageState extends State<JoinRoomPage> {
  final TextEditingController _roomCodeController = TextEditingController();
  String? errorMessage;

  Future<void> joinRoom() async {
    final response = await http.post(
      Uri.parse("http://localhost:3000/joinRoom"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "roomCode": _roomCodeController.text,
        "userEmail": "user@example.com"
      }),
    );

    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RoomPage(
            roomName: data["roomData"]["roomName"],
            roomCode: data["roomData"]["roomCode"],
          ),
        ),
      );
    } else {
      setState(() {
        errorMessage = data["error"];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Join Room")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _roomCodeController,
              decoration: InputDecoration(
                labelText: "Enter Room Code",
                errorText: errorMessage,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: joinRoom, child: Text("Join")),
          ],
        ),
      ),
    );
  }
}
