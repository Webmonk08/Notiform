import 'package:flutter/material.dart';
import 'joined_rooms_list_page.dart';
import 'make_schedule_page.dart';
import 'social_media_management_page.dart';
import 'public_announcements.dart'; // ✅ Import Public Announcements Page

class StudentHomePage extends StatefulWidget {
  const StudentHomePage({Key? key}) : super(key: key);

  @override
  _StudentHomePageState createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  List<String> joinedRooms = []; // Persistent list of joined rooms

  // void _navigateToJoinedRooms() async {
  //   final updatedRooms = await Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => JoinedRoomsListPage(joinedRooms: joinedRooms),
  //     ),
  //   );

  //   if (updatedRooms != null && updatedRooms is List<String>) {
  //     setState(() {
  //       joinedRooms = updatedRooms; // Update the list after returning
  //     });
  //   }
  // }

void _navigateToMakeSchedule() async {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Home"),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              // Handle profile navigation
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed:_navigateToMakeSchedule,
              child: const Text("Join a Room"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MakeSchedulePage()),
                );
              },
              child: const Text('Make Schedules'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SocialMediaManagementPage()),
                );
              },
              child: const Text('Manage Social Media'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PublicAnnouncementsPage(isStudent: true),
                  ),
                );
              },
              child: const Text("Public Announcements"), // ✅ New Button
            ),
          ],
        ),
      ),
    );
  }
}





