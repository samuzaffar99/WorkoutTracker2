// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workout_tracker2/globals.dart';
import 'package:workout_tracker2/services/login_api.dart';
// import 'package:gradient_app_bar/gradient_app_bar.dart';

class ExerciseResults extends StatefulWidget {
  @override
  _ExerciseResultsState createState() => _ExerciseResultsState();
}

class _ExerciseResultsState extends State<ExerciseResults> {
  final currState = Get.find<Session>();

  Widget getExerciseResults() {
    return FutureBuilder(
        future: currState.api.getExercises(),
        builder: (BuildContext buildContext, AsyncSnapshot? snapshot) {
          if (snapshot!.hasError)
            throw snapshot.error!;
          else if (!snapshot.hasData) {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            print(snapshot.data);
            return ListView.builder(
                physics: ClampingScrollPhysics(),
                padding: EdgeInsets.all(5),
                itemCount: snapshot.data.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var currentItem = snapshot.data[index];
                  return Card(
                      color: Colors.grey[300],
                      elevation: 4,
                      child: Column(children: [
                        Text(currentItem["name"]),
                        Text(currentItem["difficulty"].toString()),
                        Text(currentItem["category"]),
                        if (currentItem["info"] != null)
                          Text("Info: ${currentItem["info"]}"),
                      ]));
                });
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.background,
        appBar: AppBar(
          backgroundColor: theme.appBar,
          elevation: 5,
          title: Text("Explore"),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 5,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Expanded(
                //       child: Container(
                //         margin: EdgeInsets.only(right: 30, left: 30),
                //         child: TextFormField(
                //           decoration: InputDecoration(
                //             border: OutlineInputBorder(
                //               borderRadius: BorderRadius.all(Radius.circular(10)),
                //               borderSide: BorderSide(
                //                 color: Colors.transparent,
                //               ),
                //             ),
                //             hintText: 'Search',
                //             filled: true,
                //             fillColor: Colors.white.withAlpha(200),
                //           ),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                getExerciseResults(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
