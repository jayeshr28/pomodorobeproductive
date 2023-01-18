import 'dart:math';

import 'package:flutter/material.dart';

import 'tasks_priortized_page.dart';

class PrioritizeWork extends StatelessWidget {
  const PrioritizeWork({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                "  Prioritization Metrix.",
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 30,
                  fontFamily: "Poppins",
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "   We know you have lot to do,\n   but let's first prioritize your tasks",
                style: TextStyle(
                    fontFamily: "Poppins", fontSize: 20, color: Colors.black),
              ),
              SizedBox(
                height: 45,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Urgent",
                    style: TextStyle(fontFamily: "Poppins", fontSize: 15),
                  ),
                  Text(
                    "Not Urgent",
                    style: TextStyle(fontFamily: "Poppins", fontSize: 15),
                  )
                ],
              ),

              Container(
                width: MediaQuery.of(context).size.width,
                height: 300,
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 25,
                        ),
                        Transform.rotate(
                          angle: -pi / 2,
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Important",
                            style:
                                TextStyle(fontFamily: "Poppins", fontSize: 15),
                          ),
                        ),
                        SizedBox(
                          height: 55,
                        ),
                        Transform.rotate(
                          angle: -pi / 2,
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Not Important",
                            style:
                                TextStyle(fontFamily: "Poppins", fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      right: 0,
                      child: Container(
                          height: 280,
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Image.asset(
                            "asset/images/prioritization.png",
                            fit: BoxFit.cover,
                          )),
                    )
                  ],
                ),
              ),

              Spacer(),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PomodoroPage()));
                    },
                    child: Text(
                      "Let's Start >>>",
                      style: TextStyle(
                          color: Colors.black38,
                          fontSize: 25,
                          fontFamily: "Poppins"),
                    )),
              )
              // Container(
              //   height: 300,
              //   child: GridView(
              //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //         crossAxisCount: 2),
              //     children: [
              //       Container(
              //         decoration: BoxDecoration(
              //           color: Colors.green,
              //           borderRadius: BorderRadius.circular(10),
              //         ),
              //         child: Column(
              //           children: [
              //             Text("1. Do First"),
              //             Text(
              //                 "First Focus on the important task to be done the same day")
              //           ],
              //         ),
              //       ),
              //       Container(
              //         decoration: BoxDecoration(
              //           color: Colors.blue,
              //           borderRadius: BorderRadius.circular(10),
              //         ),
              //         child: Column(
              //           children: [
              //             Text("1. Do First"),
              //             Text(
              //                 "First Focus on the important task to be done the same day")
              //           ],
              //         ),
              //       ),
              //       Container(
              //         decoration: BoxDecoration(
              //           color: Colors.green,
              //           borderRadius: BorderRadius.circular(10),
              //         ),
              //         child: Column(
              //           children: [
              //             Text("1. Do First"),
              //             Text(
              //                 "First Focus on the important task to be done the same day")
              //           ],
              //         ),
              //       ),
              //       Container(
              //         decoration: BoxDecoration(
              //           color: Colors.green,
              //           borderRadius: BorderRadius.circular(10),
              //         ),
              //         child: Column(
              //           children: [
              //             Text("1. Do First"),
              //             Text(
              //                 "First Focus on the important task to be done the same day")
              //           ],
              //         ),
              //       )
              //     ],
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
