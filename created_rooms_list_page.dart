import 'package:flutter/material.dart';
import 'room_management_page.dart';
import 'organizer_home_page.dart'; // ✅ Import Room class from here

class CreatedRoomsListPage extends StatelessWidget {
  final List<Room> rooms;

  const CreatedRoomsListPage({Key? key, required this.rooms}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Created Rooms")),
      body: rooms.isEmpty
          ? const Center(child: Text("No rooms created. Click 'Create Room' to add one."))
          : ListView.builder(
              itemCount: rooms.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(rooms[index].name),
                  subtitle: Text("Room Code: ${rooms[index].code}"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RoomManagementPage(
                          roomName: rooms[index].name,
                          roomCode: rooms[index].code,
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



