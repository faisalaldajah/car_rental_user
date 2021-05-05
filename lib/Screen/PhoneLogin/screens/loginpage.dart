import 'dart:async';
import 'package:car_rental_user/Screen/MainPage.dart';
import 'package:car_rental_user/Screen/PhoneLogin/services/authservice.dart';
import 'package:car_rental_user/Widget/GradientButton.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPages extends StatefulWidget {
  static const String id = 'login';
  @override
  _LoginPagesState createState() => _LoginPagesState();
}

class _LoginPagesState extends State<LoginPages> {
  final formKey = new GlobalKey<FormState>();

  String phoneNo, verificationId, smsCode;

  bool codeSent = false;

  var otpKey;
  CountryCode countryCode;
  Timer _timer;
  int _start = 60;
  var fullNameController = TextEditingController();

  var phoneController = TextEditingController();

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          key: formKey,
          child: ListView(
            children: [
              SizedBox(
                height: 50,
              ),
              SvgPicture.asset(
                'assets/images/logo.svg',
                width: 150,
                height: 150,
              ),
              SizedBox(height: 20),
              Center(
                child: Text(
                  'Welcome.',
                  style: TextStyle(fontFamily: 'bolt', fontSize: 26),
                ),
              ),
              Center(
                child: Text(
                  'Rent best car in Jordan',
                  style: TextStyle(fontFamily: 'bolt', fontSize: 30),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  CountryCodePicker(
                    initialSelection: 'JO',
                    showCountryOnly: false,
                    showOnlyCountryWhenClosed: false,
                    favorite: ['+962', 'JO'],
                    showFlagMain: true,
                    onInit: (value) {
                      countryCode = value;
                    },
                    onChanged: (value){
                      countryCode=value;
                    },
                  ),
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.only(left: 25.0, right: 25.0),
                      child: TextFormField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(hintText: '7********'),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 30),
                child: TextFormField(
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(hintText: 'الاسم الكامل'),
                  controller: fullNameController,
                ),
              ),
              SizedBox(height: 30),
              codeSent ? Center(child: Text('$_start')) : Container(),
              SizedBox(height: 30),
              codeSent
                  ? Padding(
                      padding: EdgeInsets.only(left: 25.0, right: 25.0),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: (otpKey == null) ? 'ادخل الرمز' : otpKey,
                        ),
                        onChanged: (val) {
                          setState(() {
                            this.smsCode = val;
                          });
                        },
                      ))
                  : Container(),
              SizedBox(height: 50),
              Padding(
                  padding: EdgeInsets.only(left: 25.0, right: 25.0),
                  child: GradientButton(
                      title: codeSent ? 'تسجيل' : 'تأكيد',
                      onPressed: () {
                        codeSent
                            ? AuthService()
                                .signInWithOTP(smsCode, verificationId)
                            : verifyPhone(phoneController.text, countryCode.toString());
                      }))
            ],
          )),
    );
  }

//verifyPhone(phoneNo);
//print('$otpKey${phoneController.text}');
  Future<void> verifyPhone(var phoneNo, var otp) async {
    startTimer();
    var phoneNumber = '$otp$phoneNo';
    final PhoneVerificationCompleted verified =
        (PhoneAuthCredential credential) async {
      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) async {
        if (value.user != null) {
          otpKey = credential.smsCode;
          print('otpkey: $otpKey');
          DatabaseReference newUserRef = FirebaseDatabase.instance.reference();

          //Prepare data to be saved on users table
          Map userMap = {
            'fullname': fullNameController.text,
            'phone': phoneNumber,
          };

          newUserRef.child('users/${value.user.uid}').set(userMap);

          Navigator.pushNamed(context, MainPage.id);
        }
      });
    };

    final PhoneVerificationFailed verificationfailed =
        (FirebaseAuthException authException) {
      print('authException: ${authException.message}');
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      this.verificationId = verId;
      print('object: $verificationId');
      setState(() {
        this.codeSent = true;
      });
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verificationId = verId;
      print('object: $verificationId');
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 60),
      verificationCompleted: verified,
      verificationFailed: verificationfailed,
      codeSent: smsSent,
      codeAutoRetrievalTimeout: autoTimeout,
    );
    fullNameController.clear();
    phoneController.clear();
  }
}
