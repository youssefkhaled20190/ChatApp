import 'dart:io';

import 'package:chatapp/widgits/auth/authform.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:toast/toast.dart';

import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  bool isloading = false;

  void _submitAuthform(String email, String Password, String username,
      File Image, bool islogin, BuildContext ctx) async {
    ToastContext().init(ctx);

    UserCredential _authresult;
    try {
      setState(() {
        isloading = true;
      });

      _authresult = await _auth.createUserWithEmailAndPassword(
          email: email, password: Password);
      final ref = FirebaseStorage.instance
          .ref()
          .child('user_image')
          .child(_authresult.user!.uid + '.jpg');

      await ref.putFile(Image);

      final url = await ref.getDownloadURL();

      FirebaseFirestore.instance
          .collection("Users")
          .doc(_authresult.user?.uid)
          .set({
        'username': username,
        'password': Password,
        'image_url': url,
      });
    } on FirebaseAuthException catch (e) {
      String errormsg = "not FOUND";
      if (e.code == 'weak-password') {
        errormsg = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errormsg = 'The account already exists for that email.';
      } else if (e.code == 'user-not-found') {
        errormsg = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        errormsg = 'Wrong password provided for that user.';
      }
      Toast.show(errormsg, gravity: Toast.center, duration: Toast.lengthLong);
      setState(() {
        isloading = false;
      });
    } catch (e) {
      print(e);
      if (mounted) {
        setState(() {
          isloading = false;
        });
      }
    }
  }

  void _submitAuthform2(String email, String Password, String username,
      bool islogin, BuildContext ctx) async {
    ToastContext().init(ctx);

    UserCredential _authresult;
    try {
      setState(() {
        isloading = true;
      });

      _authresult = await _auth.signInWithEmailAndPassword(
          email: email, password: Password);
    } on FirebaseAuthException catch (e) {
      String errormsg = "not FOUND";
      if (e.code == 'weak-password') {
        errormsg = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errormsg = 'The account already exists for that email.';
      } else if (e.code == 'user-not-found') {
        errormsg = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        errormsg = 'Wrong password provided for that user.';
      }
      Toast.show(errormsg, gravity: Toast.center, duration: Toast.lengthLong);
      setState(() {
        isloading = false;
      });
    } catch (e) {
      print(e);
      if (mounted) {
        setState(() {
          isloading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_submitAuthform, _submitAuthform2, isloading),
    );
  }
}
