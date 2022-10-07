// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'package:chatapp/widgits/fonts/customtxt.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble(this.message, this.username, this.userimage, this.isme,
      {this.key});

  final Key? key;
  final String message;
  final String username;
  final String userimage;
  final bool isme;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment:
              isme ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: isme ? Colors.white : Colors.purple,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(14),
                  topRight: const Radius.circular(14),
                  bottomLeft: !isme
                      ? const Radius.circular(0.0)
                      : const Radius.circular(14),
                  bottomRight: isme
                      ? const Radius.circular(0.0)
                      : const Radius.circular(14),
                ),
              ),
              width: 140,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: Column(
                crossAxisAlignment:
                    isme ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Txt(username, isme ? Colors.black : Colors.white, 17),
                  Txt(message, isme ? Colors.black : Colors.white, 13)
                ],
              ),
            )
          ],
        ),
        Positioned(
          top: 0,
          left: !isme ? 120 : null,
          right: isme ? 120 : null,
          child: CircleAvatar(
            backgroundImage: NetworkImage(userimage),
          ),
        ),
      ],
      clipBehavior: Clip.none,
    );
  }
}
