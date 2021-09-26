import 'package:flutter/material.dart';

class LogPage extends StatefulWidget {
  LogPage();

  @override
  _LogPageState createState() => _LogPageState();
}

class _LogPageState extends State<LogPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: theme.background,
        appBar: AppBar(
          // backgroundColor: theme.appBar,
          elevation: 5,
          title: Text("Log"),
          centerTitle: true,
        ),
        body: Container(
          child: ListView(
            children: [
              SizedBox(height: 50),
              Text(
                'No Logs',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  // color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 300),
              Text(
                '7 Day Streak',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  // color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              InkWell(
                onTap: () {
                  //Navigator.pop(context);
                  //Insert new navigation page here
                },
                child: Center(
                  child: RichText(
                    text: TextSpan(
                      text: 'View last session',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      // widget.user.log=null;
                      // _api.putUser(widget.user);
                      // Navigator.pop(context);
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) {
                      //       return;
                      //     },
                      //   ),
                      // );
                    },
                    child: Text(
                      "Clear Log",
                      style: TextStyle(
                        fontSize: 20,
                        // color: Colors.white.withAlpha(230),
                      ),
                    ),
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
