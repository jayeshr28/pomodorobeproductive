import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

import '../widgets/music.dart';

class CountdownPomoPage extends StatefulWidget {
  Color color;
  CountdownPomoPage({Key? key, required this.color}) : super(key: key);

  @override
  State<CountdownPomoPage> createState() => _CountdownPomoPageState();
}

class _CountdownPomoPageState extends State<CountdownPomoPage>
    with SingleTickerProviderStateMixin {
  static const String POMODORO = "pomodoro";
  static const String SHORT_BREAK = "shortBreak";
  static const String LONG_BREAK = "longBreak";
  IconData playPause = FontAwesomeIcons.play;
  String focus = "Focus on Process!";
  String message = "Focus on Process!";
  String rest = "Time to take a break";
  Color textColor = Colors.white;
  String lottie = "asset/lottie/lofi.json";
  var timerDetails = {
    "pomodoro": 25,
    "shortBreak": 5,
    "longBreak": 15,
    "longBreakInterval": 4,
    "session": 0,
    "mode": "pomodoro",
    "remainingTime": {"total": 25 * 60, "minute": 25, "second": 0}
  };
  late Timer interval = Timer(const Duration(seconds: 1), () {});

  String minutes = "25";
  String seconds = "00";

  String currentTask = "Your Task";
  String customMode = POMODORO;
  void switchColor(String mode) {
    setState(() {
      if (mode == POMODORO) {
        customMode = POMODORO;
        widget.color = Colors.deepPurple;
        textColor = Colors.white;
        lottie = "asset/lottie/lofi.json";
      } else if (mode == SHORT_BREAK) {
        customMode = SHORT_BREAK;
        widget.color = Colors.green;
        textColor = Colors.white;
        lottie = "asset/lottie/short.json";
      } else if (mode == LONG_BREAK) {
        customMode = LONG_BREAK;
        textColor = Colors.black;
        widget.color = Colors.pink;
        lottie = "asset/lottie/long.json";
      }
    });
  }

  void switchMode(String mode) {
    stopTimer();
    timerDetails["mode"] = mode;
    int time = (timerDetails[mode] ?? 0) as int;
    timerDetails["remainingTime"] = {
      "total": time * 60,
      "minute": timerDetails[mode],
      "second": 0
    };

    setState(() {
      if (mode == POMODORO) {
        message = focus;
      } else {
        message = rest;
      }
    });

    switchColor(mode);
    updateClock();
  }

  void updateClock() {
    Map remainingTime = timerDetails["remainingTime"] as Map;
    setState(() {
      minutes = "${remainingTime["minute"]}".padLeft(2, "0");
      seconds = "${remainingTime["second"]}".padLeft(2, "0");
    });
  }

  int timeElapsed = 0;
  void startTimer() {
    Map remainingTime = timerDetails["remainingTime"] as Map;
    int total = remainingTime["total"];
    var endTime = DateTime.now().add(Duration(seconds: total));

    if (timerDetails["mode"] == POMODORO) {
      timerDetails["session"] = (timerDetails["session"] as int) + 1;
    }

    setState(() {
      playPause = FontAwesomeIcons.pause;
    });

    interval = Timer.periodic(const Duration(seconds: 1), (timer) {
      timerDetails["remainingTime"] = getRemainingTime(endTime);
      updateClock();

      Map remainingTime = timerDetails["remainingTime"] as Map;
      int total = remainingTime["total"];
      if (total <= 0) {
        interval.cancel();
        // audioPlayer.play();

        switch (timerDetails["mode"]) {
          case POMODORO:
            int timerSession = timerDetails["session"] as int;
            int longBreakInterval = timerDetails["longBreakInterval"] as int;

            if (timerSession % longBreakInterval == 0) {
              switchMode(LONG_BREAK);
            } else {
              switchMode(SHORT_BREAK);
            }
            break;
          default:
            switchMode(POMODORO);
        }
        startTimer();
      }
    });
  }

  void stopTimer() {
    interval.cancel();
    setState(() {
      playPause = FontAwesomeIcons.play;
    });
  }

  Map<String, int> getRemainingTime(DateTime endTime) {
    DateTime currentTime = DateTime.now();
    Duration different = endTime.difference(currentTime);

    int total = different.inSeconds;
    int minute = different.inMinutes;
    int second = total % 60;
    timeElapsed = 25 - minute;
    return {"total": total, "minute": minute, "second": second};
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // audioPlayer.dispose();
    taskController.dispose();
  }

  @override
  void initState() {
    super.initState();
    initialiseSP();
  }

  late SharedPreferences sharedPreferences;
  late List<String> taskList = [];
  late List<String> timeElapsedList = [];

  void initialiseSP() async {
    sharedPreferences = await SharedPreferences.getInstance();
    taskList = sharedPreferences.getStringList('taskList')!;
    timeElapsedList = sharedPreferences.getStringList('timeElapsed')!;
  }

  void storeData() {
    // TasksData data = TasksData(task: currentTask, time: timeElapsed.toString());
    String finaltaskdata = currentTask;
    String timeData = timeElapsed.toString();
    taskList.add(finaltaskdata);
    timeElapsedList.add(timeData);
    sharedPreferences.setStringList('taskList', taskList);
    sharedPreferences.setStringList('timeElapsed', timeElapsedList);
  }

  final taskController = TextEditingController();
  void showTaskDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Enter task",
              style: TextStyle(fontFamily: "Poppins"),
            ),
            content: Padding(
              padding: EdgeInsets.all(0),
              child: Form(
                child: TextFormField(
                  controller: taskController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(width: 3, color: Colors.black),
                          borderRadius: BorderRadius.circular(14)),
                      labelText: "Task's name",
                      icon: Icon(Icons.edit)),
                ),
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    // print(taskController.text);
                    setState(() {
                      currentTask = taskController.text;
                    });
                  },
                  child: Text("Continue"))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.color,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: TextButton(
                  onPressed: () {
                    switchMode(POMODORO);
                  },
                  child: Text(
                    "  pomodoro.",
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: textColor),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  padding: const EdgeInsets.all(15),
                  width: 280,
                  height: 70,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(60)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        currentTask,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                            fontSize: 15),
                      ),
                      IconButton(
                        onPressed: () {
                          showTaskDialog();
                        },
                        icon: FaIcon(FontAwesomeIcons.pen),
                        iconSize: 18,
                      ),
                      Spacer(),
                      CircleAvatar(
                          backgroundColor: Colors.white,
                          child: IconButton(
                            onPressed: () {
                              storeData();
                              Navigator.pop(context);
                            },
                            icon: customMode == POMODORO
                                ? Icon(
                                    Icons.cancel_outlined,
                                    color: Colors.black,
                                  )
                                : Icon(Icons.done),
                          ))
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),

              Text(
                message,
                style: TextStyle(
                    color: textColor, fontFamily: 'Poppins', fontSize: 30),
              ),
              SizedBox(
                height: 20,
              ),
              Container(width: 200, child: Lottie.asset(lottie)),
              // Step 8
              Text(
                '$minutes : $seconds',
                style: TextStyle(
                    color: textColor, fontSize: 70, fontFamily: 'Montserrat'),
              ),
              SizedBox(height: 50),

              Container(
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    customMode == POMODORO
                        ? TextButton(
                            onPressed: () {
                              switchMode(SHORT_BREAK);
                            },
                            child: Text(
                              "Short Break",
                              style: TextStyle(
                                  fontFamily: "Poppins", color: textColor),
                            ))
                        : TextButton(
                            onPressed: () {
                              switchMode(POMODORO);
                            },
                            child: Text(
                              "End Break",
                              style: TextStyle(
                                  fontFamily: "Poppins", color: textColor),
                            )),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white30),
                      child: IconButton(
                        onPressed: () {
                          if (playPause == FontAwesomeIcons.play) {
                            startTimer();
                          } else {
                            stopTimer();
                          }
                        },
                        icon: FaIcon(
                          playPause,
                        ),
                        color: textColor,
                      ),
                    ).px4(),
                    SizedBox(
                      width: 10,
                    ),
                    MusicPlayer(
                      color: textColor,
                    ).px4(),
                    TextButton(
                        onPressed: () {
                          switchMode(LONG_BREAK);
                        },
                        child: Text(
                          "Long Break",
                          style: TextStyle(
                              fontFamily: "Poppins", color: textColor),
                        )),
                  ],
                ),
              ),

              // TextButton(
              //   child: Text(
              //     "Completed? Let's start a next task",
              //     style: TextStyle(fontFamily: 'Poppins', color: Colors.white),
              //   ),
              //   onPressed: () {},
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
