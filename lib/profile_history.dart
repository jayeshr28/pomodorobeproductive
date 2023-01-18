import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pomodorobeproductive/model/shared_pref.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfileHistory extends StatefulWidget {
  const ProfileHistory({Key? key}) : super(key: key);

  @override
  State<ProfileHistory> createState() => _ProfileHistoryState();
}

class _ProfileHistoryState extends State<ProfileHistory> {
  late SharedPreferences sharedPreferences;
  late List<String> taskList = [];
  late List<String> timeElapsedList = [];

  Future clearField(int index) async {
    sharedPreferences = await SharedPreferences.getInstance();
    taskList.removeAt(index);
    timeElapsedList.removeAt(index);
    setState(() {
      sharedPreferences.setStringList('taskList', taskList);
      sharedPreferences.setStringList('timeElapsed', timeElapsedList);
      // sharedPreferences.getStringList('dataList');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<String>(
          future: SharedPreferenceHelper.getStringName(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) =>
              snapshot.hasData
                  ? Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              FutureBuilder<String>(
                                future:
                                    SharedPreferenceHelper.getStringGender(),
                                builder: (BuildContext context,
                                        AsyncSnapshot snapshott) =>
                                    snapshott.hasData
                                        ? CircleAvatar(
                                            radius: 90,
                                            child: snapshott.data == "\"Male\""
                                                ? Image.asset(
                                                    "asset/images/profile_male.png")
                                                : Image.asset(
                                                    "asset/images/profile_female.png"))
                                        : CircularProgressIndicator(),
                              ),
                              Text(
                                "Hey ${snapshot.data?.substring(1, (snapshot.data?.length)! - 1)}",
                                style: TextStyle(
                                    fontSize: 25,
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ).p16(),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Dashboard",
                            style:
                                TextStyle(fontFamily: "Poppins", fontSize: 25),
                          ).px16(),
                          FutureBuilder<dynamic>(
                            future: SharedPreferenceHelper.getHistory(),
                            builder: (BuildContext context,
                                    AsyncSnapshot history) =>
                                history.hasData
                                    ? Container(
                                        height: 400,
                                        child: ListView.builder(
                                            itemCount:
                                                history.data["taskName"].length,
                                            padding: const EdgeInsets.all(20),
                                            itemBuilder: (ctx, i) {
                                              return ListTile(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                tileColor: Colors.blue
                                                    .withOpacity(0.3),
                                                title: Text(
                                                  history.data["taskName"][i],
                                                  style: TextStyle(
                                                      fontFamily: "Poppins"),
                                                ),
                                                subtitle: Text(
                                                  "Time Elapsed : " +
                                                      history.data[
                                                          "taskDuration"][i] +
                                                      " minutes",
                                                  style: TextStyle(
                                                      fontFamily: "Poppins"),
                                                ),
                                                trailing: IconButton(
                                                  onPressed: () {
                                                    clearField(i);
                                                  },
                                                  icon: Icon(Icons.delete),
                                                ),
                                              ).py8();
                                            }))
                                    : Container(
                                        child: Lottie.asset(
                                            "asset/lottie/empty.json"),
                                      ),
                          ),
                        ],
                      ),
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
        ),
      ),
    );
  }
}
