import 'package:flutter/material.dart';
import 'package:workout_tracker2/ui/ui_navbar.dart';
// import 'package:gradient_app_bar/gradient_app_bar.dart';
// import 'package:intl/intl.dart';
import 'package:workout_tracker2/globals.dart';

// String objdiet="5febf179775c8a5c445e0745";

class DietPage extends StatefulWidget {
  DietPage();
  @override
  _DietPageState createState() => _DietPageState();
}

class _DietPageState extends State<DietPage> {
  Widget getDietView() {
    return FutureBuilder(
        future: currState.api.getDiet("gKLu2bspriy4NFEv6lPy"),
        builder: (buildContext, AsyncSnapshot snapshot) {
          if (snapshot.hasError)
            throw snapshot.error;
          else if (!snapshot.hasData) {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            String dday = "monday";
            // var dday = DateFormat('EEEE').format(DateTime.now()).toLowerCase();
            print(dday);
            int dindex = 0;
            for (var i = 0; i < snapshot.data["dietdays"].length; i++) {
              if (snapshot.data["dietdays"][i]["day"] == dday) {
                print(snapshot.data["dietdays"][i]["day"]);
                dindex = i;
                break;
              }
            }
            var currentDietDay = snapshot.data["dietdays"][dindex];
            print(snapshot.data);
            // print(
            //     'Num exercises: ${snapshot.data["days"][dindex]["routine"].length}');
            return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        currentDietDay["day"],
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  Expanded(
                      child: ListView.builder(
                          itemCount: currentDietDay["meals"].length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            var currentMeal = currentDietDay["meals"][index];
                            print('FoodId: ${currentMeal.runtimeType}');
                            print('FoodId: $currentMeal');
                            return FutureBuilder(
                                future: currState.api.getFood(currentMeal),
                                builder:
                                    (buildContext, AsyncSnapshot snapshot) {
                                  if (snapshot.hasError) {
                                    throw snapshot.error;
                                  } else if (!snapshot.hasData) {
                                    return Container(
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  } else {
                                    return Card(
                                      color: Colors.grey[300],
                                      elevation: 4,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            child: RichText(
                                              text: TextSpan(
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black,
                                                  ),
                                                  children: [
                                                    TextSpan(
                                                        text:
                                                            "    ${snapshot.data["name"]}",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                  ]),
                                            ),
                                            width: 100,
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                child: RichText(
                                                  text: TextSpan(
                                                      children: [
                                                        TextSpan(
                                                          text: "    \n",
                                                        ),
                                                        TextSpan(
                                                          text: "    Fat\n",
                                                        ),
                                                        TextSpan(
                                                          text:
                                                              "    Proteins\n",
                                                        ),
                                                        TextSpan(
                                                          text: "    Carbs\n",
                                                        ),
                                                        TextSpan(
                                                          text: "    Calories",
                                                        ),
                                                      ],
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.black,
                                                      )),
                                                ),
                                                width: 100,
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                child: RichText(
                                                  text: TextSpan(
                                                      children: [
                                                        TextSpan(
                                                          text: "Amount (g)\n",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        TextSpan(
                                                          text:
                                                              "    ${snapshot.data["fat"]}\n",
                                                        ),
                                                        TextSpan(
                                                          text:
                                                              "    ${snapshot.data["protein"]}\n",
                                                        ),
                                                        TextSpan(
                                                          text:
                                                              "    ${snapshot.data["carbs"]}\n",
                                                        ),
                                                        TextSpan(
                                                          text:
                                                              "    ${snapshot.data["calories"]}",
                                                        ),
                                                      ],
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.black,
                                                      )),
                                                ),
                                                width: 100,
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                });
                          }))
                ]);
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    // int index = 1;
    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.background,
        appBar: AppBar(
          backgroundColor: theme.appBar,
          elevation: 5,
          title: Text('Diet', style: TextStyle(color: theme.appBarText)),
        ),
        bottomNavigationBar: NavigationBar(1),
        endDrawer: Drawer(
          child: Opacity(
            opacity: 0.8,
            child: Container(
              color: Color(0xFF5F3E40),
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(
                      'Choose Your Diet',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    title: Text(
                      'Keto Diet',
                      style: TextStyle(fontSize: 17, color: Colors.white),
                    ),
                    trailing: Icon(Icons.lunch_dining, color: Colors.white),
                    onTap: () {
                      // objdiet="5febf179775c8a5c445e0743";
                      setState(() {});
                    },
                  ),
                  ListTile(
                    title: Text(
                      'Paleo Diet',
                      style: TextStyle(fontSize: 17, color: Colors.white),
                    ),
                    trailing: Icon(Icons.breakfast_dining, color: Colors.white),
                    onTap: () {
                      // objdiet="5febf179775c8a5c445e0744";
                      setState(() {});
                    },
                  ),
                  ListTile(
                    title: Text(
                      'Macho Diet',
                      style: TextStyle(fontSize: 17, color: Colors.white),
                    ),
                    trailing:
                        Icon(Icons.local_dining_outlined, color: Colors.white),
                    onTap: () {
                      // objdiet="5febf179775c8a5c445e0745";
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Container(
            height: double.infinity,
            width: double.infinity,
            child: Opacity(
              opacity: 0.5,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 5,
                margin: EdgeInsets.fromLTRB(16, 10, 16, 10),
                child: Padding(
                    padding: const EdgeInsets.all(15.0), child: getDietView()),
              ),
            )),
      ),
    );
  }
}
