import 'package:chat_app/services/chat/chat_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../auth/auth_service.dart';

class ChatPage extends StatelessWidget {
  final String email;
  final String receiverID;
  ChatPage({super.key, required this.email, required this.receiverID});

  final TextEditingController messageController = TextEditingController();
  final ChatService chatService = ChatService();
  final AuthService aurthService = AuthService();

  void sendMessage() {
    if (messageController.text.isEmpty) return;
    chatService.sendMessage(receiverID, messageController.text);
    messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(email),
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: chatService.getMessages(receiverID),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                return ListView(
                  children: snapshot.data!.docs
                      .map<Widget>((message) => _buildMessage(message))
                      .toList(),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 8, bottom: 20),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      hintText: 'Type a message',
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  margin: EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.arrow_upward_rounded),
                    onPressed: sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessage(message) {
    final String currentUid = aurthService.getUid();
    final String senderId = message['senderId'];
    final String messageText = message['message'];

    return Align(
      alignment:
          senderId == currentUid ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: senderId == currentUid
              ? Colors.blue
              : Color.fromRGBO(220, 220, 220, 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(messageText,
            style: TextStyle(
                fontSize: 16,
                color: senderId == currentUid ? Colors.white : Colors.black)),
      ),
    );
  }
}
