import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:workout_tracker2/globals.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  bool isLoading = false;
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    isSignedIn();
  }

  void isSignedIn() async {
    this.setState(() {
      isLoading = true;
    });

    isLoggedIn = await currState.googleSignIn.isSignedIn();
    if (isLoggedIn) {
      await currState.initializeUser();
      Navigator.pushReplacementNamed(context, "Home");
    }

    this.setState(() {
      isLoading = false;
    });
  }

  Future<Null> handleSignIn() async {
    this.setState(() {
      isLoading = true;
    });
    bool existsUser = await currState.initializeUser();
    Fluttertoast.showToast(msg: "Sign in success");
    this.setState(() {
      isLoading = false;
    });
    if (existsUser) {
      // Navigator.pushNamed(context, "Setup");
      Navigator.pushReplacementNamed(context, "Home");
    } else {
      Navigator.pushNamed(context, "Setup");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Login",
              // style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            backgroundColor: theme.appBar,
          ),
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                OutlinedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                    ),
                    onPressed: () => handleSignIn().catchError((err) {
                          print(err);
                          Fluttertoast.showToast(msg: "Sign in fail");
                          this.setState(() {
                            isLoading = false;
                          });
                        }),
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image(
                                image: AssetImage("assets/g-logo.png"),
                                height: 35.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  'Sign in with Google',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ]))),
                SizedBox(height: 10),
                // Loading
                Container(
                  child:
                      isLoading ? const CircularProgressIndicator() : Container(),
                ),
              ],
            ),
          )),
    );
  }
}
