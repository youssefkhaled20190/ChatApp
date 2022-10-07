import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessages extends StatefulWidget {
  @override
  State<NewMessages> createState() => _NewMessagesState();
}

class _NewMessagesState extends State<NewMessages> {
  final _controller = TextEditingController();
  String _enterdmessage = "";

  _sendmessage() async {
    FocusScope.of(context).unfocus();

    final user = FirebaseAuth.instance.currentUser;
    final userDate = await FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.uid)
        .get();
    FirebaseFirestore.instance.collection('chat').add({
      'text': _enterdmessage,
      'createdAt': Timestamp.now(),
      'username': userDate['username'],
      'userId': user.uid,
      'userImage': userDate['image_url'],
    });
    _controller.clear();
    setState(() {
      _enterdmessage = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              autocorrect: true,
              enableSuggestions: true,
              textCapitalization: TextCapitalization.sentences,
              cursorColor: Colors.white,
              controller: _controller,
              decoration: const InputDecoration(
                  hintText: "Send Message",
                  disabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black))),
              onChanged: (val) {
                setState(() {
                  _enterdmessage = val;
                });
              },
            ),
          ),
          IconButton(
            onPressed: _enterdmessage.trim().isEmpty ? null : _sendmessage,
            icon: const Icon(Icons.send),
          )
        ],
      ),
    );
  }
}
