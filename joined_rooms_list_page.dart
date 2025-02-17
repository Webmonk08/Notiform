import 'package:flutter/material.dart';
import 'room_page.dart';

class JoinedRoomsListPage extends StatefulWidget {
  final List<Map<String, String>> joinedRooms;
  
  const JoinedRoomsListPage({Key? key, required this.joinedRooms}) : super(key: key);
  
  @override
  _JoinedRoomsListPageState createState() => _JoinedRoomsListPageState();
}

class _JoinedRoomsListPageState extends State<JoinedRoomsListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Joined Rooms")),
      body: widget.joinedRooms.isEmpty
          ? Center(child: const Text("No rooms joined yet."))
          : ListView.builder(
              itemCount: widget.joinedRooms.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(widget.joinedRooms[index]["roomName"]!),
                  subtitle: Text("Room Code: ${widget.joinedRooms[index]["roomCode"]}"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RoomPage(
                          roomName: widget.joinedRooms[index]["roomName"]!,
                          roomCode: widget.joinedRooms[index]["roomCode"]!,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
