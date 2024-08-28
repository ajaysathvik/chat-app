import 'package:chat_app/model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<List<Map<String, dynamic>>> getUsers() {
    return _firestore.collection('Users').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();
        return user;
      }).toList();
    });
  }

  Future<void> sendMessage(String receiverID, message) async {
    final String currentUid = _auth.currentUser!.uid;
    final String currentEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    Message newmessage = Message(
      senderId: currentUid,
      receiverId: receiverID,
      message: message,
      timestamp: timestamp,
      senderEmail: currentEmail,
    );

    List<String> ids = [currentUid, receiverID];
    ids.sort();

    String chatId = ids.join('_');

    await _firestore
        .collection('Chats')
        .doc(chatId)
        .collection("Messages")
        .add(newmessage.toMap());
  }

  Stream<QuerySnapshot> getMessages(String receiverID) {
    final String currentUid = _auth.currentUser!.uid;
    List<String> ids = [currentUid, receiverID];
    ids.sort();

    String chatId = ids.join('_');

    return _firestore
        .collection('Chats')
        .doc(chatId)
        .collection("Messages")
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
