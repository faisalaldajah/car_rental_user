import 'package:car_rental_user/utils.dart';
import 'package:flutter/material.dart';

class SmallBtn extends StatefulWidget {
  final String title;
  final Function onPressed;
  final Color color;

  SmallBtn({@required this.title, this.onPressed, this.color});

  @override
  _SmallBtnState createState() => _SmallBtnState();
}

class _SmallBtnState extends State<SmallBtn> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              (widget.color == null) ? colorBtn : widget.color,
              (widget.color == null) ? colorBtn1 : widget.color,
            ]),
      ),
      child: TextButton(
        onPressed: widget.onPressed,
        child: Text(
          widget.title,
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }
}
