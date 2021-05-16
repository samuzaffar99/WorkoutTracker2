import 'package:flutter/material.dart';
import 'package:workout_tracker2/api.dart';
import 'package:workout_tracker2/model.dart';
import 'package:crypt/crypt.dart';
import '../others/animated_background.dart';

class SignInPage extends StatefulWidget {
  final Api _api = Api();
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  String username;
  String password;
  User user;
  bool check = true;
  var _formKey = GlobalKey<FormState>();

  Future<bool> _loginUser() async {
    print('...inside _loginUser');
    await widget._api.getUser(username).then((value) {
      setState(
        () {
          user = value;
          print('set state $value');
        },
      );
    });
    if (user == null) {
      print('user null');
      return false;
    } else {
      print(Crypt(user.hash));
      print(password);
      if (Crypt(user.hash).match(password)) {
        print('...returning true');
        return true;
      } else {
        print('...returning false');
        return false;
      }
      // if (user.password == password) {
      //   print('...returning true');
      //   return true;
      // } else {
      //   print('...returning false');
      //   return false;
      // }
    }
  }

  User users(User value) => user = value;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF141414),
        body: Container(
          height: double.infinity,
          child: Stack(
            children: [
              Positioned.fill(
                  child: AnimatedBackground()),
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
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment(0,1.1),
                      children: [
                        Image.asset('assets/images/pic5.jpg'),
                        Text(
                          'Welcome',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 40,
                            color: Colors.white.withAlpha(220),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                IconTheme(
                                  child: Icon(Icons.person),
                                  data: IconThemeData(color: Colors.white),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(10, 10, 20, 0),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.all(Radius.circular(20)),
                                          borderSide: BorderSide(
                                            color: Colors.transparent,
                                          ),
                                        ),
                                        hintText: 'Username',
                                        filled: true,
                                        fillColor: Colors.white.withAlpha(200),
                                      ),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return "Username cannot be left blank";
                                        } else if (check == false && user == null) {
                                          setState(
                                            () {
                                              check = true;
                                            },
                                          );
                                          return "Username is incorrect";
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        username = value;
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                IconTheme(
                                  child: Icon(Icons.lock),
                                  data: IconThemeData(color: Colors.white),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
                                    child: TextFormField(
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.all(Radius.circular(20)),
                                          borderSide: BorderSide(
                                            color: Colors.transparent,
                                          ),
                                        ),
                                        hintText: 'Password',
                                        filled: true,
                                        fillColor: Colors.white.withAlpha(200),
                                      ),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return "Password cannot be left blank";
                                        } else if (check == false && user != null) {
                                          print(user.username);
                                          setState(() {
                                            check = true;
                                          });
                                          return "Password is incorrect";
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        password = value;
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ButtonTheme(
                          height: 45.0,
                          minWidth: 200.0,
                          child: OutlinedButton(
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                await _loginUser().then(
                                  (value) {
                                    print('$value');
                                    if (value == true) {
                                      Navigator.popUntil(
                                          context, ModalRoute.withName('/ui_home'));
                                      Navigator.pushNamed(context, 'Home',
                                          arguments: user);
                                    } else {
                                      setState(() {
                                        check = false;
                                        _formKey.currentState.validate();
                                      });
                                    }
                                  },
                                );
                              }
                            },
                            // shape: RoundedRectangleBorder(
                            //   borderRadius: BorderRadius.circular(30.0),
                            // ),
                            // color: Colors.transparent,
                            // textColor: Colors.white,
                            // borderSide: BorderSide(
                            //     color: Colors.white.withAlpha(200), width: 1.25),
                            // highlightedBorderColor: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Log In",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white.withAlpha(220),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, 'Sign Up');
                      },
                      child: Center(
                        child: RichText(
                          text: TextSpan(
                            text: 'Don\'t have an account?',
                            style: TextStyle(color: Colors.black.withAlpha(220),fontSize: 16),
                            children: [
                              TextSpan(
                                text: ' Sign Up',
                                style: TextStyle(
                                    color: Colors.white.withAlpha(220), fontWeight: FontWeight.w800),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
