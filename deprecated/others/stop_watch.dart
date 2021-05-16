import 'dart:async';

import 'package:flutter/material.dart';

class FlutterStopWatch extends StatefulWidget {
  @override
  _FlutterStopWatchState createState() => _FlutterStopWatchState();
}

class _FlutterStopWatchState extends State<FlutterStopWatch> {
  bool flag = true;
  Stream<int> timerStream;
  StreamSubscription<int> timerSubscription;
  String hoursStr = '00';
  String minutesStr = '00';
  String secondsStr = '00';

  Stream<int> stopWatchStream() {
    StreamController<int> streamController;
    Timer timer;
    Duration timerInterval = Duration(seconds: 1);
    int counter = 0;

    void stopTimer() {
      if (timer != null) {
        timer.cancel();
        timer = null;
        counter = 0;
        streamController.close();
      }
    }

    void tick(_) {
      counter++;
      streamController.add(counter);
      if (!flag) {
        stopTimer();
      }
    }

    void startTimer() {
      timer = Timer.periodic(timerInterval, tick);
    }

    streamController = StreamController<int>(
      onListen: startTimer,
      onCancel: stopTimer,
      onResume: startTimer,
      onPause: stopTimer,
    );

    return streamController.stream;
  }

  clockStart(){
    timerStream = stopWatchStream();
    timerSubscription = timerStream.listen((int newTick) {
      setState(() {
        hoursStr = ((newTick / (60 * 60)) % 60)
            .floor()
            .toString()
            .padLeft(2, '0');
        minutesStr = ((newTick / 60) % 60)
            .floor()
            .toString()
            .padLeft(2, '0');
        secondsStr =
            (newTick % 60).floor().toString().padLeft(2, '0');
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    clockStart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "\n$hoursStr:$minutesStr:$secondsStr",
              style: TextStyle(
                fontSize: 30.0,
              ),
            ),
            SizedBox(height: 20.0),
          ],
        ),
      );
  }
}