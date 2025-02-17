import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PublicAnnouncementsPage extends StatefulWidget {
  final bool isStudent; // ✅ Control access

  const PublicAnnouncementsPage({Key? key, required this.isStudent}) : super(key: key);

  @override
  _PublicAnnouncementsPageState createState() => _PublicAnnouncementsPageState();
}

class _PublicAnnouncementsPageState extends State<PublicAnnouncementsPage> {
  Uint8List? _imageBytes;
  final TextEditingController _topicController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _linkController = TextEditingController();
  final TextEditingController _deadlineController = TextEditingController();

  List<Map<String, dynamic>> announcements = [];

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      final Uint8List imageBytes = await image.readAsBytes();
      setState(() {
        _imageBytes = imageBytes;
      });
    }
  }

  void _addAnnouncement() {
    if (_topicController.text.isEmpty || _descriptionController.text.isEmpty) {
      return;
    }

    setState(() {
      announcements.add({
        "topic": _topicController.text,
        "description": _descriptionController.text,
        "link": _linkController.text.isNotEmpty ? _linkController.text : null,
        "deadline": _deadlineController.text.isNotEmpty ? _deadlineController.text : null,
        "image": _imageBytes,
      });

      // Clear fields after posting
      _topicController.clear();
      _descriptionController.clear();
      _linkController.clear();
      _deadlineController.clear();
      _imageBytes = null;
    });

    Navigator.pop(context); // Close dialog
  }

  void _showAddAnnouncementDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("New Announcement"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(controller: _topicController, decoration: const InputDecoration(labelText: "Topic")),
                TextField(controller: _descriptionController, decoration: const InputDecoration(labelText: "Description")),
                TextField(controller: _linkController, decoration: const InputDecoration(labelText: "Link (Optional)")),
                TextField(controller: _deadlineController, decoration: const InputDecoration(labelText: "Deadline (Optional)")),
                const SizedBox(height: 10),
                ElevatedButton(onPressed: _pickImage, child: const Text("Pick Image")),
                if (_imageBytes != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.memory(
                        _imageBytes!,
                        width: MediaQuery.of(context).size.width * 0.8, // ✅ Responsive width
                        height: MediaQuery.of(context).size.height * 0.3, // ✅ Responsive height
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
            ElevatedButton(onPressed: _addAnnouncement, child: const Text("Post")),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Public Announcements")),
      body: announcements.isEmpty
          ? const Center(child: Text("No announcements available", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)))
          : ListView.builder(
              itemCount: announcements.length,
              itemBuilder: (context, index) {
                final announcement = announcements[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(announcement["topic"], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        const SizedBox(height: 5),
                        Text(announcement["description"], style: const TextStyle(fontSize: 14)),
                        if (announcement["link"] != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(
                              "🔗 ${announcement["link"]}",
                              style: const TextStyle(color: Colors.blue, fontSize: 14),
                            ),
                          ),
                        if (announcement["deadline"] != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(
                              "📅 Deadline: ${announcement["deadline"]}",
                              style: const TextStyle(color: Colors.red, fontSize: 14),
                            ),
                          ),
                        if (announcement["image"] != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.memory(
                                announcement["image"],
                                width: MediaQuery.of(context).size.width * 0.85, // ✅ Consistent width
                                height: MediaQuery.of(context).size.height * 0.3, // ✅ Consistent height
                                fit: BoxFit.cover, // ✅ Ensures image scales correctly
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: widget.isStudent
          ? null // ✅ Hide "Add Post" button for students
          : FloatingActionButton(
              onPressed: _showAddAnnouncementDialog,
              child: const Icon(Icons.add),
            ),
    );
  }
}
