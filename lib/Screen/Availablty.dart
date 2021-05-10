import 'package:car_rental_user/models/CarInfo.dart';
import 'package:car_rental_user/models/PaymentData.dart';
import 'package:car_rental_user/utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Availablty extends StatefulWidget {
  final CarInfo carInfo;
  Availablty({this.carInfo});
  @override
  _AvailabltyState createState() => _AvailabltyState();
}

class _AvailabltyState extends State<Availablty> {
  List<PaymentData> allPaymensData = [];
  bool youHaveData = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff5f5f5),
      appBar: AppBar(
        title: Text('Availablty'),
        backgroundColor: Color(0xfff5f5f5),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(15),
        child: (youHaveData != true)
            ? Container(child: Center(child: Text('Wait to get data')))
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'Reservation details',
                      style: pageTitle,
                    ),
                  ),
                  Flexible(
                    child: Container(
                      child: ListView.builder(
                          itemCount: allPaymensData.length,
                          itemBuilder: (context, index) {
                            return DataDetails(
                              allPaymensData: allPaymensData,
                              index: index,
                            );
                          }),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future<void> getData() async {
    DatabaseReference availabltyRef = FirebaseDatabase.instance
        .reference()
        .child('cars/${widget.carInfo.key}/availability');
    PaymentData paymentData;
    var keys;
    String from;
    String to;
    String paymentMethod;
    int totalprice;
    String phone;
    String name;
    var avKey;

    availabltyRef.once().then((DataSnapshot snapshot) {
      keys = snapshot.value.keys;
      print(keys);
      for (var key in keys) {
        avKey = key;
        from = snapshot.value[key]['from'];
        to = snapshot.value[key]['to'];
        paymentMethod = snapshot.value[key]['payment_method'];
        phone = snapshot.value[key]['phone'];
        totalprice = snapshot.value[key]['price'];
        name = snapshot.value[key]['name'];

        paymentData = PaymentData(
          from: from,
          name: name,
          paymentMethod: paymentMethod,
          phone: phone,
          to: to,
          totalprice: totalprice,
          key: avKey,
        );
        allPaymensData.add(paymentData);
      }
      setState(() {
        youHaveData = true;
      });
    });
  }
}

class DataDetails extends StatelessWidget {
  final List<PaymentData> allPaymensData;
  final index;
  DataDetails({this.allPaymensData, this.index});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(10),
      width: double.infinity,
      color: Colors.grey[300],
      height: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'id: ${allPaymensData[index].key}',
            style: bodyText,
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('Form: ${allPaymensData[index].from}',style: bodyText,),
              Text('To: ${allPaymensData[index].to}',style: bodyText,),
            ],
          )
        ],
      ),
    );
  }
}
