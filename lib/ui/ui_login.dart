import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/login_api.dart';

class LoginPage extends StatelessWidget {
  // bool isLoading = false;
  // bool isLoggedIn = false;
  final Session session = Get.find<Session>();

  @override
  // void initState() {
  //   super.initState();
  //   isSignedIn();
  // }
  //
  // void isSignedIn() async {
  //   this.setState(() {
  //     isLoading = true;
  //   });
  //
  //   isLoggedIn = await currState.googleSignIn.isSignedIn();
  //   if (isLoggedIn) {
  //     bool existsUser = await currState.initializeUser();
  //     if (existsUser) {
  //       // Navigator.pushNamed(context, "Setup");
  //       Navigator.pushReplacementNamed(context, "Home");
  //     } else {
  //       Navigator.pushNamed(context, "Setup");
  //     }
  //   }
  //
  //   this.setState(() {
  //     isLoading = false;
  //   });
  // }
  //
  // Future<Null> handleSignIn() async {
  //   this.setState(() {
  //     isLoading = true;
  //   });
  //   bool existsUser = await currState.initializeUser();
  //   Fluttertoast.showToast(msg: "Sign in success");
  //   this.setState(() {
  //     isLoading = false;
  //   });
  //   if (existsUser) {
  //     print("unga bunga");
  //     // Navigator.pushNamed(context, "Setup");
  //     Navigator.pushReplacementNamed(context, "Home");
  //   } else {
  //     print("not unga bunga");
  //     Navigator.pushNamed(context, "Setup");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            // backgroundColor: theme.appBar,
            elevation: 5,
            title: Text("Login"),
            centerTitle: true,
          ),
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 10),
                // Loading
                LoginButton(),
                Container(
                  child: session.isLoading.value
                      ? const CircularProgressIndicator()
                      : Container(),
                ),
              ],
            ),
          )),
    );
  }
}

class LoginButton extends StatelessWidget {
  final Session session = Get.find<Session>();
  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
          elevation: 1,
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        ),
        onPressed: () => session.handleSignIn().catchError((err) {
              print(err);
              Get.snackbar("Error!", "Sign in fail");
              // Fluttertoast.showToast(msg: "Sign in fail");
              session.isLoading.value = false;
            }),
        label: Text(
          'Sign in with Google',
          textAlign: TextAlign.end,
          style: TextStyle(
            fontSize: 20,
            color: Colors.black54,
            fontWeight: FontWeight.w600,
          ),
        ),
        icon: Image(
          image: AssetImage("assets/g-logo.png"),
          height: 35.0,
        ));
  }
}
