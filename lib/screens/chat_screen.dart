import 'package:chating_app/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/master_builder_stream.dart';

late User signedInUser;

class ChatScreen extends StatefulWidget {
  static const screenRoute = 'chat_screen';
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  String? messageText;
  final messageTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        signedInUser = user;
        print(signedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              _auth.signOut();
              Navigator.popAndPushNamed(context, WelcomeSreen.screenroute);
              ;
            },
            icon: const Icon(Icons.close),
          ),
        ],
        backgroundColor: Colors.yellow[900]!,
        title: Row(
          children: [
            Image.asset('images/logo.png', height: 25),
            const SizedBox(width: 8),
            const Text('Chat'),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: MessageStreamBuilder(firestore: _firestore),
            ),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.orange,
                    width: 2,
                  ),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        setState(() {
                          messageText = value;
                        });
                      },
                      decoration: const InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        hintText: 'Write here your message...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      if (messageText != null &&
                          messageText!.trim().isNotEmpty) {
                        _firestore.collection('Messages').add({
                          'Text': messageText,
                          'sender': signedInUser.email,
                          'timestamp': FieldValue.serverTimestamp(),
                        });
                        messageTextController.clear();
                        setState(() {
                          messageText = null;
                        });
                      }
                    },
                    child: Text(
                      'Send',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[800]!,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
