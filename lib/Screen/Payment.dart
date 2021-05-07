import 'package:car_rental_user/Widget/GradientButton.dart';
import 'package:car_rental_user/Widget/SmallBtn.dart';
import 'package:car_rental_user/models/DataProvider.dart';
import 'package:car_rental_user/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class Payment extends StatefulWidget {
  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  var cash = false;
  var card = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff5f5f5),
      appBar: AppBar(
        title: Text(
          'Payment',
          style: pageTitle,
        ),
        elevation: 0,
        backgroundColor: Color(0xfff5f5f5),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 30),
            Icon(
              Icons.payments_rounded,
              size: 130,
              color: colorBtn1,
            ),
            SizedBox(height: 15),
            Text('name'),
            SizedBox(height: 15),
            Text('phone number'),
            SizedBox(height: 20),
            Text(
              'Choose payment method',
              style: TextStyle(fontSize: 18.0),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                  activeColor: Colors.blue,
                  value: cash,
                  onChanged: (value) {
                    setState(() {
                      cash = value;
                      card = false;
                    });
                  },
                ),
                Text(
                  'Cash',
                  style: TextStyle(fontSize: 17.0),
                ),
                SizedBox(width: 20),
                Checkbox(
                  activeColor: Colors.blue,
                  value: card,
                  onChanged: (value) {
                    setState(() {
                      card = value;
                      cash = false;
                    });
                  },
                ),
                Text(
                  'Card',
                  style: TextStyle(fontSize: 17.0),
                ),
              ],
            ),
            SizedBox(height: 30),
            Text(
              'total payment',
              style: TextStyle(fontSize: 40),
            ),
            SizedBox(height: 20),
            Expanded(
                child: Container(
              child: Column(
                children: [
                  Text('Thasnk you for choosing us'),
                  SvgPicture.asset(
                    'assets/images/logo.svg',
                    width: 120,
                    height: 120,
                  ),
                ],
              ),
            )),
            GradientButton(
              title: 'Confirm',
              onPressed: () {
                getPaid();
              },
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void getPaid() {
    if (cash == true && card == true) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => OnePaymentMetod(),
      );
    } else if (cash == true && card == false) {}
  }
}

class OnePaymentMetod extends StatelessWidget {
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Please checke one payment method',
              textAlign: TextAlign.center,
              style: bodyText,
            ),
            Icon(
              Icons.payment_rounded,
              size: 40,
            ),
            SmallBtn(
              title: 'Confirm',
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
