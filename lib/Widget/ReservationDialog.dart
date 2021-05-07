import 'package:car_rental_user/Screen/Payment.dart';
import 'package:car_rental_user/Widget/SmallBtn.dart';
import 'package:car_rental_user/models/CarInfo.dart';
import 'package:car_rental_user/models/DataProvider.dart';
import 'package:car_rental_user/utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReservationDialog extends StatefulWidget {
  final CarInfo carInfo;
  ReservationDialog({this.carInfo});
  @override
  _ReservationDialogState createState() => _ReservationDialogState();
}

class _ReservationDialogState extends State<ReservationDialog> {
  DateTime currentDate = DateTime.now();
  DateTime start = DateTime.now();
  DateTime end = DateTime.now();
  var userName;
  var phone;
  bool  dateer = false;

  @override
  void initState() {
    userFullName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.transparent,
      child: Container(
        margin: EdgeInsets.all(16),
        width: double.infinity,
        height: 280,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Choose the days you want to rent the car',
                  textAlign: TextAlign.center, style: bodyText),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'From:',
                      style: bodyText,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '${start.year}/${start.month}/${start.day}',
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    CircleAvatar(
                      backgroundColor: colorBtn,
                      child: IconButton(
                        icon: Icon(
                          Icons.calendar_today_rounded,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          _startDate(context);
                        },
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'To:',
                      style: bodyText,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '${end.year}/${end.month}/${end.day}',
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    CircleAvatar(
                      backgroundColor: colorBtn,
                      child: IconButton(
                        icon: Icon(
                          Icons.calendar_today_rounded,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          _endDate(context);
                        },
                      ),
                    )
                  ],
                ),
              ),
              SmallBtn(
                title: 'Confirm',
                onPressed: () {
                  availabilityCar();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Payment()));
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void userFullName() {
    DatabaseReference userRef = FirebaseDatabase.instance
        .reference()
        .child('users/${currentFirebaseUser.uid}');

    userRef.once().then((DataSnapshot snapshot) {
      userName = snapshot.value['fullname'];
      phone = snapshot.value['phone'];
      print('user:$userName');
    });
  }

  void availabilityCar() {
    //print('key:${widget.carInfo.key}');
    DatabaseReference carRef = FirebaseDatabase.instance
        .reference()
        .child('cars/${widget.carInfo.key}');
     if (currentFirebaseUser != null && dateer == false) {
      Map availabilityCar = {
        'availability': 'not available',
        'from': '${start.year}/${start.month}/${start.day}',
        'to': '${end.year}/${end.month}/${end.day}',
        'name': userName,
        'phone': phone
      };
      carRef.child('availability').set(availabilityCar);
    }
  }

  Future<void> _endDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: start,
        firstDate: DateTime(2020),
        lastDate: DateTime(2022));
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        end = pickedDate;
      });
  }

  Future<void> _startDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: start,
        firstDate: DateTime(2020),
        lastDate: DateTime(2022));
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        start = pickedDate;
      });
  }
}

class DateBtn extends StatelessWidget {
  final String date;
  final Function onTap;
  DateBtn({
    @required this.date,
    this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 110,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(child: Text((date != null) ? date : '', style: bodyText)),
      ),
    );
  }
}
