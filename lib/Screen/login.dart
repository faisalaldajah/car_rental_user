import 'package:car_rental_user/Screen/ResetPassword.dart';
import 'package:car_rental_user/Screen/registration.dart';
import 'package:car_rental_user/Widget/GradientButton.dart';
import 'package:car_rental_user/Widget/ProgressDialog.dart';
import 'package:car_rental_user/utils.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'mainpage.dart';

class LoginPage extends StatefulWidget {
  static const String id = 'login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  User user;
  void showSnackBar(String title) {
    final snackbar = SnackBar(
      content: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 15),
      ),
    );
    // ignore: deprecated_member_use
    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  void login() async {
    //show please wait dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => ProgressDialog(
        status: 'Logging you in',
      ),
    );
    final User user = (await _auth
            .signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    )
            .catchError((errMsg) {
      Navigator.pop(context);
      displayToastMessage('Wrong email or password', context);
    }))
        .user;

    if (user != null) {
      DatabaseReference userRef =
          FirebaseDatabase.instance.reference().child('users/${user.uid}');
      setState(() {
        userLoggedin = true;
        currentFirebaseUser = user;
      });
      
      userRef.once().then((DataSnapshot snapshot) {
        if (snapshot.value != null) {
          Navigator.pushNamedAndRemoveUntil(
              context, MainPage.id, (route) => false);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 30,
                ),
                SvgPicture.asset(
                  'assets/images/logo.svg',
                  width: 120,
                  height: 120,
                ),
                SizedBox(height: 20),
                Text(
                  'Welcome.',
                  style: TextStyle(fontFamily: 'bolt', fontSize: 30),
                ),
                Text(
                  'Best car for you.',
                  style: TextStyle(fontFamily: 'bolt', fontSize: 33),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            labelText: 'Email address',
                            labelStyle: TextStyle(
                              fontSize: 14.0,
                            ),
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 10.0)),
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(
                              fontSize: 14.0,
                            ),
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 10.0)),
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      GradientButton(
                        title: 'Login',
                        onPressed: () async {
                          //check network availability

                          var connectivityResult =
                              await Connectivity().checkConnectivity();
                          if (connectivityResult != ConnectivityResult.mobile &&
                              connectivityResult != ConnectivityResult.wifi) {
                            showSnackBar('No internet connectivity');
                            return;
                          }

                          if (!emailController.text.contains('@')) {
                            showSnackBar('Please enter a valid email address');
                            return;
                          }

                          if (passwordController.text.length < 8) {
                            showSnackBar('Please enter a valid password');
                            return;
                          }
                          setState(() {
                            login();
                          });
                        },
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, ResetPassword.id, (route) => false);
                  },
                  child: Text(
                    'Forget password',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, RegistrationPage.id, (route) => false);
                  },
                  child: Text(
                    'Don\'t have an account, sign up here',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
