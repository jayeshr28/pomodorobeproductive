import 'package:flutter/material.dart';

import '../pomodoro_timer_page.dart';

class TaskCard extends StatelessWidget {
  Color color;
  String priority;
  String task;
  TaskCard(
      {Key? key,
      required this.color,
      required this.priority,
      required this.task})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      height: 350,
      padding: const EdgeInsets.symmetric(horizontal: 30),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 50,
          ),
          Align(
            alignment: Alignment.center,
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CountdownPomoPage(color: color)));
              },
              child: Container(
                alignment: Alignment.center,
                height: 90,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("asset/images/liquid2.gif")),
                ),
                child: Image.asset("asset/images/play_button.gif"),
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Text(
            task,
            style: TextStyle(
                fontFamily: 'Poppins', color: Colors.white, fontSize: 23),
          ),
          Text(
            "Deadline: Today 11:59PM",
            style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.white.withOpacity(0.5),
                fontSize: 15),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Priority",
                style: TextStyle(
                    color: Colors.white, fontFamily: 'Poppins', fontSize: 16),
              ),
              Text(
                priority,
                style: TextStyle(
                    color: Colors.white, fontFamily: 'Poppins', fontSize: 16),
              )
            ],
          )
        ],
      ),
    );
  }
}
