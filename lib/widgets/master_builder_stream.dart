import 'package:chating_app/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/message_line.dart';

class MessageStreamBuilder extends StatelessWidget {
  const MessageStreamBuilder({
    super.key,
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  final FirebaseFirestore _firestore;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream:
          _firestore.collection('Messages').orderBy('timestamp').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }

        final messages = snapshot.data?.docs.reversed ?? [];
        List<MessageLine> messageWidgets = [];
        for (var message in messages) {
          final messageText = message.get('Text');
          final messageSender = message.get('sender');
          final currentUser = signedInUser.email;

          final messageWidget = MessageLine(
            sender: messageSender,
            text: messageText,
            isMe: currentUser == messageSender,
          );
          messageWidgets.add(messageWidget);
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 18),
            children: messageWidgets,
          ),
        );
      },
    );
  }
}
