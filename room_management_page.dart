import 'package:flutter/material.dart';

class RoomManagementPage extends StatefulWidget {
  final String roomName;
  final String roomCode;

  const RoomManagementPage({Key? key, required this.roomName, required this.roomCode}) : super(key: key);

  @override
  _RoomManagementPageState createState() => _RoomManagementPageState();
}

class _RoomManagementPageState extends State<RoomManagementPage> {
  List<String> joinedStudents = ["student1@college.edu", "student2@college.edu"];
  List<String> requests = ["user1@gmail.com", "user2@gmail.com"];
  
  List<Map<String, String>> announcements = []; // ✅ Store announcements

  bool showRequests = false;
  bool showJoinedStudents = false;

  void _assignTasks() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Assign Tasks"),
          content: const Text("Task assignment feature coming soon!"),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text("OK"))
          ],
        );
      },
    );
  }

  void _createPolls() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Create Polls"),
          content: const Text("Poll creation feature coming soon!"),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text("OK"))
          ],
        );
      },
    );
  }

  void _makeAnnouncements() {
    TextEditingController topicController = TextEditingController();
    TextEditingController linkController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    TextEditingController deadlineController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Make an Announcement"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: topicController,
                  decoration: const InputDecoration(labelText: "Topic"),
                ),
                TextField(
                  controller: linkController,
                  decoration: const InputDecoration(labelText: "Link (Optional)"),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: "Description"),
                  maxLines: 3,
                ),
                TextField(
                  controller: deadlineController,
                  decoration: const InputDecoration(labelText: "Deadline"),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                String topic = topicController.text.trim();
                String link = linkController.text.trim();
                String description = descriptionController.text.trim();
                String deadline = deadlineController.text.trim();

                if (topic.isNotEmpty && description.isNotEmpty && deadline.isNotEmpty) {
                  setState(() {
                    announcements.add({
                      "topic": topic,
                      "description": description,
                      "deadline": deadline,
                      "link": link
                    });
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Announcement added successfully!")),
                  );

                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please fill in all required fields.")),
                  );
                }
              },
              child: const Text("Submit"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${widget.roomName} - Code: ${widget.roomCode}")),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Joined Students Button
            ElevatedButton(
              onPressed: () {
                setState(() {
                  showJoinedStudents = !showJoinedStudents;
                });
              },
              child: const Text("View Joined Students"),
            ),

            // Joined Students List (Visible when clicked)
            if (showJoinedStudents)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: joinedStudents.map((student) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(student),
                )).toList(),
              ),

            const SizedBox(height: 20),

            // Requests Button
            ElevatedButton(
              onPressed: () {
                setState(() {
                  showRequests = !showRequests;
                });
              },
              child: const Text("View Requests"),
            ),

            // Requests List (Visible when clicked)
            if (showRequests)
              Column(
                children: requests.map((req) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(req),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            joinedStudents.add(req);
                            requests.remove(req);
                          });
                        },
                        child: const Text("Approve"),
                      ),
                    ],
                  );
                }).toList(),
              ),

            const SizedBox(height: 20),

            // Announcements Section
            const Text("Announcements:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: announcements.length,
                itemBuilder: (context, index) {
                  final announcement = announcements[index];
                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("📢 ${announcement['topic']!}", 
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 5),
                          Text("📝 ${announcement['description']!}"),
                          const SizedBox(height: 5),
                          Text("📅 Deadline: ${announcement['deadline']!}", 
                              style: const TextStyle(color: Colors.red)),
                          if (announcement['link']!.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text("🔗 Link: ${announcement['link']!}",
                                  style: const TextStyle(color: Colors.blue, decoration: TextDecoration.underline)),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 10),

            // Assign Tasks, Create Polls & Make Announcements (Bottom Center)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _assignTasks,
                  child: const Text("Assign Tasks"),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _createPolls,
                  child: const Text("Create Polls"),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _makeAnnouncements,
                  child: const Text("Make Announcements"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}




