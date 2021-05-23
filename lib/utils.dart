import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

var paragraphText = TextStyle(fontFamily: 'bolt', fontSize: 14);

var bodyText = TextStyle(fontFamily: 'bolt', fontSize: 16);

var smallText = TextStyle(fontFamily: 'bolt', fontSize: 12);

var textInput = TextStyle(fontFamily: 'bolt', fontSize: 16);

var pageTitle = TextStyle(fontSize: 20, fontFamily: 'bolt');

var headerTitle = TextStyle(fontSize: 30, fontFamily: 'bolt');

Color brandColor = Color(0xff6C63FF);

Color colorBtn = Color(0xfff7a38a);
Color colorBtn1 = Color(0xfff5558b);

User currentFirebaseUser;

displayToastMessage(String message, BuildContext context) {
  Fluttertoast.showToast(msg: message);
}
bool youHaveData = false;

bool userLoggedin = false;