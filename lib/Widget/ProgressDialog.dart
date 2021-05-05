import 'package:car_rental_user/utils.dart';
import 'package:flutter/material.dart';

class ProgressDialog extends StatelessWidget {
  final String status;
  ProgressDialog({this.status});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.transparent,
      child: Container(
        margin: EdgeInsets.all(16),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            children: [
              SizedBox(width: 4),
              CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation<Color>(colorBtn),
              ),
              SizedBox(width: 25),
              Text(status, style: TextStyle(fontSize: 15))
            ],
          ),
        ),
      ),
    );
  }
}
