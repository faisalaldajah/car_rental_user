import 'package:car_rental_user/Screen/PhoneLogin/services/authservice.dart';
import 'package:car_rental_user/Widget/GradientButton.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GradientButton(
          title: 'Signout',
          onPressed: () {
            AuthService().signOut();
          },
        )
      )
    );
  }
}