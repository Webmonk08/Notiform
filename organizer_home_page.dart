import 'package:flutter/material.dart';
import 'dart:math';
import 'created_rooms_list_page.dart';
import 'make_schedule_page.dart';
import 'social_media_management_page.dart';
import 'public_announcements.dart'; 

class OrganizerHomePage extends StatefulWidget {
  const OrganizerHomePage({Key? key}) : super(key: key);

  @override
  _OrganizerHomePageState createState() => _OrganizerHomePageState();
}

class Room {
  final String name;
  final String code;

  Room(this.name) : code = _generateUniqueCode();

  static String _generateUniqueCode() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    Random random = Random();
    return List.generate(6, (index) => chars[random.nextInt(chars.length)]).join();
  }
}

class _OrganizerHomePageState extends State<OrganizerHomePage> {
  List<Room> createdRooms = [];

  void _navigateToCreateRoom() async {
    final String? newRoomName = await showDialog(
      context: context,
      builder: (context) {
        TextEditingController roomController = TextEditingController();
        return AlertDialog(
          title: const Text("Enter Room Name"),
          content: TextField(
            controller: roomController,
            decoration: const InputDecoration(hintText: "Room Name"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, null),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                String roomName = roomController.text.trim();
                if (roomName.isNotEmpty) {
                  Navigator.pop(context, roomName);
                }
              },
              child: const Text("Create"),
            ),
          ],
        );
      },
    );

    if (newRoomName != null && newRoomName.isNotEmpty) {
      setState(() {
        createdRooms.add(Room(newRoomName));
      });

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CreatedRoomsListPage(rooms: createdRooms)),
      );
    }
  }

  void _navigateToCreatedRooms() {
    Navigator.push( 
      context,
      MaterialPageRoute(
        builder: (context) => CreatedRoomsListPage(rooms: createdRooms),
      ),
    );
  }

  void _navigateToMakeSchedule() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MakeSchedulePage()),
    );
  }

  void _navigateToSocialMedia() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SocialMediaManagementPage()),
    );
  }

  void _navigateToPublicAnnouncements() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PublicAnnouncementsPage(isStudent: false,)), // ✅ Navigate to Public Announcements
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Organizer Home")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _navigateToCreateRoom,
              child: const Text("Create Room"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _navigateToCreatedRooms,
              child: const Text("View Created Rooms"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _navigateToMakeSchedule,
              child: const Text("Make Schedules"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _navigateToSocialMedia,
              child: const Text("Manage Social Media"),
            ),
            const SizedBox(height: 20),
            ElevatedButton( // ✅ New Public Announcements Button
              onPressed: _navigateToPublicAnnouncements,
              child: const Text("Public Announcements"),
            ),
          ],
        ),
      ),
    );
  }
}





