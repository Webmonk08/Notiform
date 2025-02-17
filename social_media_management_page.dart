import 'package:flutter/material.dart';

class SocialMediaManagementPage extends StatefulWidget {
  const SocialMediaManagementPage({Key? key}) : super(key: key);

  @override
  _SocialMediaManagementPageState createState() => _SocialMediaManagementPageState();
}

class _SocialMediaManagementPageState extends State<SocialMediaManagementPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _postController = TextEditingController();
  DateTime? _selectedDate;
  bool _isLoggedIn = false;
  String _selectedPlatform = "Instagram";
  List<String> _recentPosts = [];
  List<Map<String, dynamic>> _scheduledPosts = [];

  void _login() {
    if (_usernameController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
      setState(() {
        _isLoggedIn = true;
        _fetchRecentPosts();
      });
    }
  }

  void _fetchRecentPosts() {
    // Mock data: Replace with API integration for multiple social media platforms
    setState(() {
      _recentPosts = [
        "Instagram: Post 1 - Awesome Sunset!",
        "Facebook: Post 2 - New Product Launch!",
        "Instagram: Post 3 - Behind the Scenes!",
        "Facebook: Post 4 - Office Party Highlights!"
      ];
    });
  }

  void _schedulePost() {
    if (_postController.text.isNotEmpty && _selectedDate != null) {
      setState(() {
        _scheduledPosts.add({
          "content": _postController.text,
          "date": _selectedDate,
          "platform": _selectedPlatform,
        });
      });
      _postController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Social Media Management")),
      body: Column(
        children: [
          _buildNavigationBar(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: _isLoggedIn ? _buildDashboard() : _buildLoginForm(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _selectedPlatform == "Instagram" ? 0 : 1,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.camera), label: "Instagram"),
        BottomNavigationBarItem(icon: Icon(Icons.facebook), label: "Facebook"),
      ],
      onTap: (index) {
        setState(() {
          _selectedPlatform = index == 0 ? "Instagram" : "Facebook";
          _isLoggedIn = false; // Require login per platform
        });
      },
    );
  }

  Widget _buildLoginForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Login to $_selectedPlatform"),
        TextField(
          controller: _usernameController,
          decoration: const InputDecoration(labelText: "Username"),
        ),
        TextField(
          controller: _passwordController,
          decoration: const InputDecoration(labelText: "Password"),
          obscureText: true,
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _login,
          child: const Text("Login"),
        ),
      ],
    );
  }

  Widget _buildDashboard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Recent Posts & Activity on $_selectedPlatform:", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Expanded(
          child: ListView.builder(
            itemCount: _recentPosts.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(_recentPosts[index]),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text("Schedule a Post on $_selectedPlatform:", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        TextField(
          controller: _postController,
          decoration: const InputDecoration(labelText: "Write your post"),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2100),
            );
            if (pickedDate != null) {
              setState(() {
                _selectedDate = pickedDate;
              });
            }
          },
          child: const Text("Pick Date"),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: _schedulePost,
          child: const Text("Schedule Post"),
        ),
        const SizedBox(height: 20),
        const Text("Scheduled Posts:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Expanded(
          child: ListView.builder(
            itemCount: _scheduledPosts.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(_scheduledPosts[index]["content"]),
                subtitle: Text("Scheduled for: ${_scheduledPosts[index]["date"]} on ${_scheduledPosts[index]["platform"]}"),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    setState(() {
                      _scheduledPosts.removeAt(index);
                    });
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
