// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:workout_tracker2/globals.dart';
// import 'package:gradient_app_bar/gradient_app_bar.dart';

class ExerciseResults extends StatefulWidget {
  @override
  _ExerciseResultsState createState() => _ExerciseResultsState();
}

class _ExerciseResultsState extends State<ExerciseResults> {
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
          // automaticallyImplyLeading: true,
          // leading: IconButton(
          //   icon: Icon(Icons.arrow_back_rounded),
          //   onPressed: () {
          //     Navigator.pop(context);
          //   },
          // ),
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
                // SizedBox(
                //   height: 30,
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     ButtonTheme(
                //       height: 45.0,
                //       minWidth: 150.0,
                //       child: OutlineButton(
                //         onPressed: () {
                //           Navigator.pop(context);
                //         },
                //         shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(30.0),
                //         ),
                //         color: Colors.transparent,
                //         textColor: Colors.white,
                //         borderSide: BorderSide(
                //             color: Colors.white.withAlpha(200), width: 1.25),
                //         highlightedBorderColor: Colors.white,
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           children: [
                //             Text(
                //               "Filter",
                //               style: TextStyle(
                //                 fontSize: 20,
                //                 color: Colors.white.withAlpha(230),
                //                 shadows: <Shadow>[
                //                   Shadow(
                //                       offset: Offset(1.5, 1.5),
                //                       blurRadius: 5.0,
                //                       color: Color.fromARGB(255, 0, 0, 0))
                //                 ],
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                // SizedBox(
                //   height: 50,
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
