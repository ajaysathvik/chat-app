import 'package:chat_app/auth/auth_service.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/services/chat/chat_services.dart';
import 'package:flutter/material.dart';
import '../components/my_drawer.dart';
import '../components/user_tile.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final ChatService _chatService = ChatService();
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Home Page'),
      ),
      body: _buildUserList(),
      drawer: MyDrawer(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
        stream: _chatService.getUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView(
            children: snapshot.data!
                .map<Widget>((user) => _buildUserListItem(user, context))
                .toList(),
          );
        });
  }

  Widget _buildUserListItem(
      Map<String, dynamic> userdata, BuildContext context) {
    if (userdata['email'] != _auth.getEmail()) {
      return UserTile(
        text: userdata['email'],
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatPage(
                      email: userdata['email'], receiverID: userdata['uid'])));
        },
      );
    } else {
      return Container();
    }
  }
}
