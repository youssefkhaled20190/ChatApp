// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'package:chatapp/widgits/chats/messages.dart';
import 'package:chatapp/widgits/chats/new_messages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Chats",
          style: GoogleFonts.bungee(
            fontSize: 20,
            color: Colors.purple[100],
          ),
        ),
        actions: [
          DropdownButton(
            icon: Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
            items: [
              DropdownMenuItem(
                child: Row(
                  children: const [
                    Icon(
                      Icons.exit_to_app,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text("logout")
                  ],
                ),
                value: 'logout',
              )
            ],
            onChanged: (itemidentifier) {
              if (itemidentifier == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            },
          )
        ],
      ),
      body: Stack(children: [
        Image.network(
          "https://i.pinimg.com/564x/9e/a0/47/9ea0476146b78187c135d95548f0999e.jpg",
          fit: BoxFit.cover,
          height: 2000,
          width: 3000,
        ),
        Container(
          child: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Expanded(
                child: messages(),
              ),
              NewMessages()
            ],
          ),
        ),
      ]),
    );
  }
}
