import 'package:flutter/material.dart';
// import '../others/animated_background.dart';

class SetupComplete extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF141414),
        body: Container(
          height: double.infinity,
          child: Stack(
            children: [
              Positioned.fill(child: Center()),
              Column(
                children: [
                  // Image.asset(
                  //   'assets/images/pic5.jpg',
                  // ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    "Congratulations!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.white.withAlpha(230),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "You're all set up",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white.withAlpha(230),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ButtonTheme(
                        height: 45.0,
                        minWidth: 200.0,
                        child: OutlinedButton(
                          onPressed: () {
                            // Navigator.popUntil(
                            //     context, ModalRoute.withName('/ui_signin'));
                            Navigator.pushNamed(
                              context, "Home"
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Nice!",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white.withAlpha(230),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
