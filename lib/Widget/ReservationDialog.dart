import 'package:car_rental_user/Widget/SmallBtn.dart';
import 'package:car_rental_user/utils.dart';
import 'package:flutter/material.dart';

class ReservationDialog extends StatefulWidget {
  @override
  _ReservationDialogState createState() => _ReservationDialogState();
}

class _ReservationDialogState extends State<ReservationDialog> {
  DateTime currentDate = DateTime.now();
  DateTime start = DateTime.now();
  DateTime end = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.transparent,
      child: Container(
        margin: EdgeInsets.all(16),
        width: double.infinity,
        height: 350,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                '${currentDate.year}/${currentDate.month}/${currentDate.day}',
                style: bodyText,
              ),
              DateBtn(),
              Text('${currentDate.year}/${currentDate.month}/${currentDate.day}'),
              SmallBtn(
                title: 'from',
                onPressed: () {
                  _selectDate(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2020),
        lastDate: DateTime(2022));
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
      });
  }
}


class DateBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 40,
      decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(6),
        ),
    );
  }
}


