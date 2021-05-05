import 'package:car_rental_user/utils.dart';
import 'package:flutter/material.dart';

class GradientButton extends StatefulWidget {
  final String title;
  final Function onPressed;

  GradientButton({this.title, this.onPressed});

  @override
  _GradientButtonState createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              colorBtn,
              colorBtn1,
            ]),
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            spreadRadius: 0.3,
            color: colorBtn,
          ),
        ],
      ),
      child: TextButton(
        onPressed: widget.onPressed,
        child: Text(
          widget.title,
          style: TextStyle(fontSize: 25,color: Colors.white),
        ),
      ),
    );
  }
}
