import 'package:chatapp/widgits/chats/messagebubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class messages extends StatelessWidget {
  const messages({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("chat")
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (ctx, snapShoot) {
        final docs = snapShoot.data?.docs;
        final user = FirebaseAuth.instance.currentUser;

        if (snapShoot.connectionState == ConnectionState.waiting) {
          // ignore: prefer_const_constructors
          return Center(child: const CircularProgressIndicator());
        }
        return ListView.builder(
          reverse: true,
          itemCount: docs!.length,
          itemBuilder: (ctx, index) {
            return MessageBubble(
              docs[index]['text'],
              docs[index]['username'],
              docs[index]['userImage'],
              docs[index]['userId'] == user!.uid,
              key: ValueKey(docs[index].id),
            );
          },
        );
      },
    );
  }
}
