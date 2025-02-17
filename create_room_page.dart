import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CreateRoomPage extends StatefulWidget {
  @override
  _CreateRoomPageState createState() => _CreateRoomPageState();
}

class _CreateRoomPageState extends State<CreateRoomPage> {
  final TextEditingController _roomNameController = TextEditingController();
  String? roomCode;

  Future<void> createRoom() async {
    final response = await http.post(
      Uri.parse("http://localhost:3000/createRoom"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "roomName": _roomNameController.text,
        "organizerEmail": "admin@example.com"
      }),
    );

    final data = jsonDecode(response.body);
    if (response.statusCode == 201) {
      setState(() {
        roomCode = data["roomCode"];
      });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(data["error"])));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Room")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _roomNameController,
              decoration: InputDecoration(labelText: "Room Name"),
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: createRoom, child: Text("Create")),
            if (roomCode != null)
              Text("Room Code: $roomCode",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
