import 'package:car_rental_user/Widget/CarDetailCard.dart';
import 'package:car_rental_user/models/CarInfo.dart';
import 'package:car_rental_user/utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  static const String id = 'mainPage';
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<CarInfo> carsDetail = [];
  bool youHaveData = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffe8e8e8),
        appBar: AppBar(
          backgroundColor: Color(0xffe8e8e8),
          elevation: 0,
          title: Text('Welcome.'),
        ),
        body: (youHaveData != true)
            ? Container(child: Center(child: Text('Wait to get data')))
            : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text('Choose your car',style: pageTitle,),
                ),
                Flexible(
                  child: Container(
                    child: ListView.builder(
                        itemCount: carsDetail.length,
                        itemBuilder: (context, index) {
                          return CarDetailCard(
                            carsDetail: carsDetail,
                            index: index,
                          );
                        }),
                  ),
                ),
              ],
            ));
  }

  Future<void> getData() async {
    DatabaseReference carRef =
        FirebaseDatabase.instance.reference().child('cars');

    CarInfo carDetail;
    var keys;
    String carModel;
    String pricePerDay;
    String features;
    String carColor;
    String gearBox;
    String fuel;
    String carType;
    String carSeat;
    String carNumber;
    String dateOfFactor;
    String url;

    carRef.once().then((DataSnapshot snapshot) {
      keys = snapshot.value.keys;

      for (var key in keys) {
        carModel = snapshot.value[key]['carModel'];
        carNumber = snapshot.value[key]['carNumber'];
        carColor = snapshot.value[key]['carColor'];
        pricePerDay = snapshot.value[key]['pricePerDay'];
        features = snapshot.value[key]['features'];
        gearBox = snapshot.value[key]['gearBox'];
        fuel = snapshot.value[key]['fuel'];
        carType = snapshot.value[key]['carType'];
        carSeat = snapshot.value[key]['carSeat'];
        dateOfFactor = snapshot.value[key]['dateOfFactor'];
        url = snapshot.value[key]['image_url'];

        carDetail = CarInfo(
          carColor: carColor,
          carModel: carModel,
          carNumber: carNumber,
          carSeats: carSeat,
          carType: carType,
          dateOfFactor: dateOfFactor,
          features: features,
          fuel: fuel,
          gearbox: gearBox,
          pricePerDay: pricePerDay,
          urlImage: url,
        );
        carsDetail.add(carDetail);
      }
      setState(() {
        youHaveData = true;
      });
    });
  }
}
