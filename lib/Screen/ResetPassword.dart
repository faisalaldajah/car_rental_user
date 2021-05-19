import 'package:car_rental_user/Widget/GradientButton.dart';
import 'package:car_rental_user/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ResetPassword extends StatelessWidget {
  static const String id = 'ResetPassword';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController emailTextEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 30),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Text(
                'we will send you a link... please click on that link to reset your password.',
                style: bodyText,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                controller: emailTextEditingController,
                decoration: InputDecoration(
                  labelText: 'email',
                  labelStyle: TextStyle(
                    fontSize: 14,
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            GradientButton(
              title: 'Send',
              onPressed: () {
                _auth.sendPasswordResetEmail(
                  email: emailTextEditingController.text,
                );
                emailTextEditingController.clear();
                FocusScope.of(context).requestFocus(FocusNode());
                displayToastMessage('check your email please', context);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
