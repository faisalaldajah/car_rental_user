import 'package:car_rental_user/Screen/MainPage.dart';
import 'package:car_rental_user/Widget/GradientButton.dart';
import 'package:car_rental_user/Widget/SmallBtn.dart';
import 'package:car_rental_user/models/CarInfo.dart';
import 'package:car_rental_user/utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Payment extends StatefulWidget {
  final CarInfo carInfo;
  final DateTime start;
  final DateTime end;
  final String userName;
  final String phone;
  final rangeOfDayRent;
  Payment({
    this.carInfo,
    this.end,
    this.start,
    this.phone,
    this.userName,
    this.rangeOfDayRent,
  });

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  var cash = false;
  var card = false;

  var totalPrice;
  String paymentMethod;
  void totalPayment() {
    int price = int.parse(widget.carInfo.pricePerDay);
    int dayRent = widget.rangeOfDayRent + 1;
    if (widget.end.day != widget.start.day) {
      totalPrice = price * dayRent;
    }
    if (dayRent > 6) {
      double dis = (price.toDouble() * dayRent.toDouble()) * 0.8;
      totalPrice = dis;
    }
    if (widget.start.day == widget.end.day &&
        widget.start.month == widget.end.month) {
      totalPrice = price;
    }
  }

  @override
  void initState() {
    totalPayment();
    super.initState();
  }

  void availabilityCar() {
    print(totalPrice);
    if (cash == true) {
      paymentMethod = 'cash';
    }
    if (card == true) {
      paymentMethod = 'card';
    }
    DatabaseReference carRef = FirebaseDatabase.instance
        .reference()
        .child('cars/${widget.carInfo.key}').child('availability');
    if (currentFirebaseUser != null) {
      Map availabilityCar = {
        'availability': 'not available',
        'from':
            '${widget.start.year}/${widget.start.month}/${widget.start.day}',
        'to': '${widget.end.year}/${widget.end.month}/${widget.end.day}',
        'name': widget.userName,
        'phone': widget.phone,
        'price': totalPrice,
        'payment_method': paymentMethod
      };
      carRef.push().set(availabilityCar);
    }
  }

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
            Text('${widget.userName}'),
            SizedBox(height: 15),
            Text('${widget.phone}'),
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
              '${totalPrice}JD',
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
                availabilityCar();
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
    if (cash == true) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => OnePaymentMetod(),
      );
    }
    if (card == true) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => CardPayment(
          carInfo: widget.carInfo,
        ),
      );
    }
  }
}

// ignore: must_be_immutable
class OnePaymentMetod extends StatelessWidget {
  String cashPayment =
      'please pay when you get your car from our office!! after tow day your rental will dismis';

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
              cashPayment,
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
                Navigator.pushNamed(context, MainPage.id);
              },
            )
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class CardPayment extends StatelessWidget {
  CarInfo carInfo;
  CardPayment({this.carInfo});

  TextEditingController cardNumber = TextEditingController();
  TextEditingController cardHolderName = TextEditingController();
  TextEditingController exp = TextEditingController();
  TextEditingController cvc = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff5f5f5),
      appBar: AppBar(
        backgroundColor: Color(0xfff5f5f5),
        elevation: 0,
        title: Text(
          'Card Payment',
          style: pageTitle,
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_outlined,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: [
          SizedBox(height: 30),
          Icon(
            Icons.payments_outlined,
            size: 150,
            color: colorBtn1,
          ),
          SizedBox(height: 20),
          Container(
            margin: EdgeInsets.all(20),
            child: Column(
              children: [
                TextField(
                  controller: cardNumber,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'card number',
                      labelStyle: TextStyle(
                        fontSize: 14.0,
                      ),
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 10.0)),
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: cardHolderName,
                  decoration: InputDecoration(
                      labelText: 'card holder name',
                      labelStyle: TextStyle(
                        fontSize: 14.0,
                      ),
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 10.0)),
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: exp,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'EXP',
                      labelStyle: TextStyle(
                        fontSize: 14.0,
                      ),
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 10.0)),
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: cvc,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'cvc',
                      labelStyle: TextStyle(
                        fontSize: 14.0,
                      ),
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 10.0)),
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 40),
                GradientButton(
                  title: 'Confirm',
                  onPressed: () {
                    cardDetails(context);
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void cardDetails(context) {
    DatabaseReference carRef =
        FirebaseDatabase.instance.reference().child('cars/${carInfo.key}');
    Map cardDetail = {
      'cardNumber': cardNumber.text,
      'cardHolderName': cardHolderName.text,
      'exp': exp.text,
      'cvc': cvc.text,
    };
    carRef.child('availability/card').set(cardDetail);
    cardNumber.clear();
    cardHolderName.clear();
    exp.clear();
    cvc.clear();
    Navigator.pushNamed(context, MainPage.id);
  }
}
