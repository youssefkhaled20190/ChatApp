// ignore_for_file: unused_field, prefer_final_fields, non_constant_identifier_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toast/toast.dart';

import '../image/imagepicker.dart';

class AuthForm extends StatefulWidget {
  final void Function(String email, String Password, String username,
      File Image, bool islogin, BuildContext ctx) submitfn;
  final void Function(String email, String Password, String username,
      bool islogin, BuildContext ctx) submitfn2;
  final bool isloading;
  AuthForm(this.submitfn, this.submitfn2, this.isloading);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formkey = GlobalKey<FormState>();
  bool _islogin = true;
  String _email = "";
  String _password = "";
  String _Username = "";
  File? _userImageFile;
  void PickedImage(File pickedImage) {
    _userImageFile = pickedImage;
  }

  void _submit() {
    ToastContext().init(context);

    final isvalid = _formkey.currentState!.validate();

    if (!_islogin && _userImageFile == null) {
      Toast.show("Please pick an Image",
          gravity: Toast.center, duration: Toast.lengthLong);
      return;
    }

    //to turn off key board
    FocusScope.of(context).unfocus();
    if (isvalid) {
      _formkey.currentState!.save();

      if (_islogin && _userImageFile == null) {
        widget.submitfn2(_email.trim(), _password.trim(), _Username.trim(),
            _islogin, context);
      } else {
        widget.submitfn(_email.trim(), _password.trim(), _Username.trim(),
            _userImageFile!, _islogin, context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Image.network(
        "https://i.pinimg.com/564x/d5/d5/52/d5d55299f08c4a51fab28f3537726a3a.jpg",
        fit: BoxFit.cover,
        height: 2000,
        width: 3000,
      ),
      Center(
        child: Card(
          margin: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Chat",
                          style: GoogleFonts.bungee(
                            fontSize: 25,
                            color: Colors.purple[100],
                          ),
                        ),
                        Text(
                          " App",
                          style: GoogleFonts.bungee(
                            fontSize: 25,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (!_islogin) pickImage(PickedImage),
                  TextFormField(
                    autocorrect: false,
                    enableSuggestions: false,
                    textCapitalization: TextCapitalization.none,
                    //for spacifiction between widgits
                    key: const ValueKey('Email'),
                    validator: (val) {
                      if (val!.isEmpty || !val.contains('@')) {
                        return "please enter a valid email address";
                      } else {
                        return null;
                      }
                    },
                    onSaved: (val) => _email = val!,
                    keyboardType: TextInputType.emailAddress,
                    decoration:
                        const InputDecoration(labelText: "Email Address"),
                  ),
                  if (!_islogin)
                    TextFormField(
                      autocorrect: true,
                      enableSuggestions: false,
                      textCapitalization: TextCapitalization.words,
                      key: const ValueKey('username'),
                      validator: (val) {
                        if (val!.isEmpty || val.length < 4) {
                          return "please enter at least 4 chracter";
                        } else {
                          return null;
                        }
                      },
                      onSaved: (val) => _Username = val!,
                      decoration: const InputDecoration(labelText: "User Name"),
                    ),
                  TextFormField(
                    key: const ValueKey('password'),
                    validator: (val) {
                      if (val!.isEmpty || val.length < 7) {
                        return "password must be at least 7 chracters";
                      } else {
                        return null;
                      }
                    },
                    onSaved: (val) => _password = val!,
                    decoration: const InputDecoration(labelText: "Password"),
                    obscureText: true,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  if (widget.isloading) const CircularProgressIndicator(),
                  if (!widget.isloading)
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple[100],
                      ),
                      child: Text(_islogin ? 'LOGIN' : 'SignUp'),
                      onPressed: () {
                        _submit();
                      },
                    ),
                  if (!widget.isloading)
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _islogin = !_islogin;
                        });
                      },
                      child: Text(
                        _islogin
                            ? 'Create a new account?'
                            : 'I have already an account',
                        style: GoogleFonts.poppins(color: Colors.black),
                      ),
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}
