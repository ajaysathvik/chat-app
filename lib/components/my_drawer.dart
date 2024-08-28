import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../pages/setting_page.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({super.key});

  final user = FirebaseAuth.instance.currentUser;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void signOut() async {
    await _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[900],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(user!.displayName ?? 'User Name'),
                accountEmail: Text(user!.email ?? 'User Email'),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.grey.shade900,
                  child: Text('A',
                      style: TextStyle(
                          fontSize: 40.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w300)),
                ),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 59, 59, 59),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                child: ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text('    H O M E'),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text('    S E T T I N G S'),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SettingPage(),
                        ));
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0, left: 8),
            child: ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('    L O G O U T'),
              onTap: signOut,
            ),
          ),
        ],
      ),
    );
  }
}
