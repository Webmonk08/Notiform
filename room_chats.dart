import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RoomChatPage extends StatefulWidget {
  final String roomCode;

  const RoomChatPage({Key? key, required this.roomCode}) : super(key: key);

  @override
  _RoomChatPageState createState() => _RoomChatPageState();
}

class _RoomChatPageState extends State<RoomChatPage> {
  final TextEditingController messageController = TextEditingController();

  void _sendMessage() {
    if (messageController.text.isNotEmpty) {
      FirebaseFirestore.instance.collection('rooms').doc(widget.roomCode).collection('messages').add({
        'text': messageController.text,
        'timestamp': Timestamp.now(),
      });

      messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Room: ${widget.roomCode}")),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('rooms')
                  .doc(widget.roomCode)
                  .collection('messages')
                  .orderBy('timestamp')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ListView(
                  children: snapshot.data!.docs.map((doc) {
                    return ListTile(title: Text(doc['text']));
                  }).toList(),
                );
              },
            ),
          ),
          TextField(
            controller: messageController,
            decoration: InputDecoration(
              labelText: "Type a message",
              suffixIcon: IconButton(icon: Icon(Icons.send), onPressed: _sendMessage),
            ),
          ),
        ],
      ),
    );
  }
}
