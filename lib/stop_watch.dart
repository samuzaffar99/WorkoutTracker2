import 'dart:async';

import 'package:flutter/material.dart';

class FlutterStopWatch extends StatefulWidget {
  @override
  _FlutterStopWatchState createState() => _FlutterStopWatchState();
}

class _FlutterStopWatchState extends State<FlutterStopWatch> {
  bool isActive = true;
  Stream<int>? timerStream;
  StreamSubscription<int>? timerSubscription;
  String hoursStr = '00';
  String minutesStr = '00';
  String secondsStr = '00';

  @override
  void dispose() {
    timerSubscription?.cancel();
    super.dispose();
  }

  Stream<int> stopWatchStream() {
    StreamController<int>? streamController;
    Timer? timer;
    Duration timerInterval = Duration(seconds: 1);
    int counter = 0;

    void stopTimer() {
      if (timer != null) {
        timer?.cancel();
        timer = null;
        counter = 0;
        streamController?.close();
      }
    }

    void tick(_) {
      if (isActive) {
        counter++;
      }
      streamController?.add(counter);
      // if (!isActive) {
      //   stopTimer();
      // }
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

  clockStart() {
    timerStream = stopWatchStream();
    timerSubscription = timerStream?.listen((int newTick) {
      setState(() {
        hoursStr =
            ((newTick / (60 * 60)) % 60).floor().toString().padLeft(2, '0');
        minutesStr = ((newTick / 60) % 60).floor().toString().padLeft(2, '0');
        secondsStr = (newTick % 60).floor().toString().padLeft(2, '0');
      });
    });
  }

  @override
  void initState() {
    clockStart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "\n$hoursStr:$minutesStr:$secondsStr",
          style: TextStyle(
            fontSize: 30.0,
            color: Colors.white,
          ),
        ),
        IconButton(
            color: Colors.white,
            alignment: Alignment.center,
            icon: isActive ? Icon(Icons.pause) : Icon(Icons.play_arrow),
            onPressed: () {
              setState(() {
                isActive = !isActive;
                // isActive?timerSubscription.resume():timerSubscription.pause();
              });
            }),
      ],
    );
  }
}
