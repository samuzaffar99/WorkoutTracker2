import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/login_api.dart';

class LoginPage extends StatelessWidget {
  final Session session = Get.find<Session>();

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
                LoginButton(),
                SizedBox(height: 10),
                // Loading
                Obx(
                  () => Container(
                    child: session.isLoading.value
                        ? const CircularProgressIndicator()
                        : Container(),
                  ),
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
        onPressed: () => session.handleSignIn(),
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
