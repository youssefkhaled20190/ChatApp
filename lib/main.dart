// ignore_for_file: deprecated_member_use

import 'package:chatapp/screens/authscreen.dart';
import 'package:chatapp/screens/chatscreen.dart';
import 'package:chatapp/widgits/auth/authform.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          canvasColor: Colors.grey,
          primarySwatch: Colors.purple,
          accentColor: Colors.deepPurple,
          backgroundColor: Colors.pink,
          accentColorBrightness: Brightness.light,
        ),
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ChatScreen();
            } else {
              return AuthScreen();
            }
          },
        ));
  }
}
