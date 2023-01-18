import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:pomodorobeproductive/model/shared_pref.dart';
import 'package:pomodorobeproductive/profile_history.dart';
import 'package:pomodorobeproductive/widgets/task_card.dart';
import 'package:velocity_x/velocity_x.dart';

class PomodoroPage extends StatefulWidget {
  const PomodoroPage({Key? key}) : super(key: key);

  @override
  State<PomodoroPage> createState() => _PomodoroPageState();
}

class _PomodoroPageState extends State<PomodoroPage> {
  List<Color> colors = [
    Colors.pink.withOpacity(0.5),
    Colors.redAccent.withOpacity(0.5),
    Colors.deepOrangeAccent.withOpacity(0.5),
    Colors.deepOrange.withOpacity(0.4)
  ];
  String priority = '1';

  String task = "Urgent and Important";
  Color taskColor = Colors.deepPurple;
  void TaskCardChange(int i) {
    setState(() {
      priority = (i + 1).toString();
      switch (i) {
        case 0:
          taskColor = Colors.deepPurple;
          task = "Urgent and Important";
          break;
        case 1:
          taskColor = Colors.deepOrange;
          task = "Important";
          break;
        case 2:
          taskColor = Colors.green;
          task = "Delegate";
          break;
        case 3:
          taskColor = Colors.pink;
          task = "Least Important";
      }
      ;
    });
  }

  late String gender;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: FutureBuilder<String>(
          future: SharedPreferenceHelper.getStringGender(),
          builder: (BuildContext context, AsyncSnapshot snapshott) => snapshott
                  .hasData
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 50,
                                child: Image.asset(
                                  'asset/images/icon_pomo.png',
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                              Text(
                                "pomodoro.",
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.deepPurple),
                              ),
                            ],
                          ),
                          CircleAvatar(
                              child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProfileHistory(),
                                  ));
                            },
                            child: snapshott.data == "\"Male\""
                                ? Image.asset("asset/images/profile_male.png")
                                : Image.asset(
                                    "asset/images/profile_female.png"),
                          ))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Tasks for Today",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.black,
                          fontSize: 30),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Stack(
                      children: [
                        Opacity(
                          opacity: 0.2,
                          child: Transform.rotate(
                            angle: -math.pi / 20,
                            child: TaskCard(
                              color: taskColor,
                              priority: priority,
                              task: task,
                            ),
                          ),
                        ),
                        Opacity(
                          opacity: 0.1,
                          child: Transform.rotate(
                            angle: -math.pi / 30,
                            child: TaskCard(
                              color: taskColor,
                              priority: priority,
                              task: task,
                            ),
                          ),
                        ),
                        TaskCard(
                          color: taskColor,
                          priority: priority,
                          task: task,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      children: [
                        Text(
                          "Priority",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: "Poppins",
                              color: Colors.black),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 1,
                          width: 100,
                          color: Colors.black,
                        )
                      ],
                    ).px16(),
                    Container(
                      height: 110,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 4,
                          padding: const EdgeInsets.all(10),
                          itemBuilder: (ctx, i) {
                            return InkWell(
                              onTap: () {
                                TaskCardChange(i);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                margin: const EdgeInsets.all(8),
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: colors[i],
                                ),
                                child: Text(
                                  (i + 1).toString(),
                                  style: TextStyle(
                                      fontSize: 20, fontFamily: 'Montserrat'),
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                )
              : CircularProgressIndicator(),
        ),
      ),
    );
  }
}
