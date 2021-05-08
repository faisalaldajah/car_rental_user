import 'package:car_rental_user/Screen/Payment.dart';
import 'package:car_rental_user/Widget/SmallBtn.dart';
import 'package:car_rental_user/models/CarInfo.dart';
import 'package:car_rental_user/utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

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
  bool dateer = false;
  var rangeDayOfRent;

  @override
  void initState() {
    userFullName();
    super.initState();
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
                          setState(() {
                            _startDate(context);
                          });
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
                          setState(() {
                            _endDate(context);
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 5),
              SizedBox(height: 5),
              SmallBtn(
                title: 'Confirm',
                onPressed: () {
                  range();

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Payment(
                        carInfo: widget.carInfo,
                        end: end,
                        start: start,
                        phone: phone,
                        userName: userName,
                        rangeOfDayRent: rangeDayOfRent,
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _endDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
      context: context,
      initialDate: start,
      firstDate: DateTime(2020),
      lastDate: DateTime(2022),
      selectableDayPredicate: _decideWhichDayToEnable,
    );
    if (pickedDate != null && pickedDate != currentDate) {
      end.compareTo(start);
      setState(() {
        end = pickedDate;
      });
    }
  }

  bool _decideWhichDayToEnable(DateTime day) {
    if ((day.isAfter(DateTime.now().subtract(Duration(days: 1))) &&
        day.isBefore(DateTime.now().add(Duration(days: 365))))) {
      return true;
    }
    return false;
  }

  Future<void> _startDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
      context: context,
      initialDate: start,
      firstDate: DateTime(2020),
      lastDate: DateTime(2022),
      selectableDayPredicate: _decideWhichDayToEnable,
    );

    if (pickedDate != null) {
      setState(() {
        start = pickedDate;
      });
    }
  }

  void range() {
    rangeDayOfRent = end.difference(start);
    if (rangeDayOfRent == 0) {
      rangeDayOfRent += 1;
    }
    var dayRents = rangeDayOfRent.toString().split(":")[0];
    rangeDayOfRent = int.parse(dayRents) ~/ 24;
    print('day: $rangeDayOfRent');
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
