import 'package:car_rental_user/Screen/Availablty.dart';
import 'package:car_rental_user/Screen/login.dart';
import 'package:car_rental_user/Widget/GradientButton.dart';
import 'package:car_rental_user/Widget/ReservationDialog.dart';
import 'package:car_rental_user/models/CarInfo.dart';
import 'package:car_rental_user/utils.dart';
import 'package:flutter/material.dart';

class ViewCarDetails extends StatelessWidget {
  final CarInfo carInfo;
  ViewCarDetails({this.carInfo});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff5f5f5),
      appBar: AppBar(
        backgroundColor: Color(0xfff5f5f5),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        elevation: 0,
        title: Text('Vehicle'),
      ),
      body: Column(
        children: [
          Flexible(
            child: Container(
              child: ListView(
                children: [
                  Container(
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${carInfo.carModel} ${carInfo.carType}',
                          style: headerTitle,
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          height: 250,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage('${carInfo.urlImage}'),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.all(15),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Icon(Icons.event_seat_outlined),
                                      SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Seats',
                                            style: bodyText,
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            '${carInfo.carSeats} person',
                                            style: bodyText,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(15),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Icon(Icons.local_gas_station),
                                      SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'fuel',
                                            style: bodyText,
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            '${carInfo.fuel}',
                                            style: bodyText,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(15),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Icon(Icons
                                          .precision_manufacturing_outlined),
                                      SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'year',
                                            style: bodyText,
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            '${carInfo.dateOfFactor}',
                                            style: bodyText,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.all(15),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Icon(Icons.color_lens_outlined),
                                      SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Color',
                                            style: bodyText,
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            '${carInfo.carColor}',
                                            style: bodyText,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(15),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Icon(Icons.drive_eta),
                                      SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'gearbox',
                                            style: bodyText,
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            '${carInfo.gearbox}',
                                            style: bodyText,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(15),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Icon(Icons.event),
                                      SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      Availablty(
                                                    carInfo: carInfo,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Text(
                                              'Availablty',
                                              style: bodyText,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            'Availablty',
                                            style: bodyText,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Divider(
                          thickness: 1.5,
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: 15, right: 15, bottom: 15, top: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Features',
                                style: pageTitle,
                              ),
                              SizedBox(height: 5),
                              Text(
                                ' ${carInfo.features}',
                                style: bodyText,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(15),
            width: double.infinity,
            height: 135,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
              color: Colors.white,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.payment_outlined),
                    Text('Price per day', style: bodyText),
                    Icon(Icons.arrow_forward),
                    Text('${carInfo.pricePerDay}JD')
                  ],
                ),
                SizedBox(height: 15),
                GradientButton(
                  title: 'Reservation',
                  onPressed: () {
                    if (currentFirebaseUser != null) {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) => ReservationDialog(
                          carInfo: carInfo,
                        ),
                      );
                    } else {
                      Navigator.pushNamed(context, LoginPage.id);
                    }
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
