import 'package:flutter/material.dart';
import 'ui_signin.dart';
import '../others/animated_background.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF141414),
        body: Container(
          height: double.infinity,
          child: Stack(
            children: [
              Positioned.fill(child: AnimatedBackground()),
              onBottom(AnimatedWave(
                height: 180,
                speed: 1,
              )),
              onBottom(AnimatedWave(
                height: 120,
                speed: 0.9,
                offset: 3.142,
              )),
              onBottom(AnimatedWave(
                height: 220,
                speed: 1.2,
                offset: 3.142 / 2,
              )),
              Positioned.fill(child: Center()),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment(0,1),
                    children: [
                      Image.asset(
                        'assets/images/pic2.jpg',
                      ),
                      Text(
                        'Welcome to FitMan',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.w800,
                          fontSize: 36,
                          color: Colors.white.withAlpha(200),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Lets get you up to shape',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.white.withAlpha(220),
                    ),
                  ),
                  SizedBox(
                    height: 13,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ButtonTheme(
                        height: 45.0,
                        minWidth: 200.0,
                        child: OutlineButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return SignInPage();
                                },
                              ),
                            );
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          color: Colors.transparent,
                          textColor: Colors.white.withAlpha(200),
                          borderSide: BorderSide(
                              color: Colors.white.withAlpha(200), width: 1.25),
                          highlightedBorderColor: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(width: 2.0),
                              Text(
                                "Next",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white.withAlpha(230),
                                ),
                              ),
                              SizedBox(width: 2.5),
                              Icon(Icons.arrow_forward, color: Colors.white.withAlpha(230),)
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
