import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pomodorobeproductive/prioritize_task.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

import 'gender/gender.dart';
import 'model/user_data.dart';

class UserForm extends StatefulWidget {
  const UserForm({Key? key}) : super(key: key);

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final name = new TextEditingController();
  List<Gender> genders = <Gender>[];
  late SharedPreferences sharedPreferences;
  late String username;
  late String gender;

  void initialiseSP() async {
    sharedPreferences = await SharedPreferences.getInstance();
    username = sharedPreferences.getString('user')!;
    gender = sharedPreferences.getString('gender')!;
  }

  final _formkey = GlobalKey<FormState>();

  void storeData() {
    UserData data = UserData(name: name.text, gender: gender);
    username = jsonEncode(data.name);
    gender = jsonEncode(data.gender);
    setState(() {
      sharedPreferences.setString('user', username);
      sharedPreferences.setString('gender', gender);
    });
  }

  Future<void> _submit() async {
    if (!_formkey.currentState!.validate()) {
      return;
    }
    _formkey.currentState!.save();
  }

  @override
  void initState() {
    super.initState();
    initialiseSP();
    genders.add(Gender("Male", MdiIcons.genderMale, false));
    genders.add(Gender("Female", MdiIcons.genderFemale, false));
    genders.add(Gender("Others", MdiIcons.genderTransgender, false));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  Image.asset("asset/images/profile_pomo.jpg"),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: "Enter Your Name",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                                BorderSide(width: 3, color: Colors.black))),
                    controller: name,
                  ).px8(),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Select Gender",
                    style: TextStyle(fontFamily: "Poppins", fontSize: 25),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 120,
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                        itemCount: genders.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            splashColor: Colors.pinkAccent,
                            onTap: () {
                              setState(() {
                                gender = genders[index].name;
                                genders.forEach(
                                    (gender) => gender.isSelected = false);
                                genders[index].isSelected = true;
                              });
                            },
                            child: CustomRadio(genders[index]),
                          );
                        }),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      onPressed: () {
                        _submit();
                        storeData();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PrioritizeWork()));
                      },
                      child: Text(
                        "Continue",
                        style: TextStyle(fontFamily: "Poppins"),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          elevation: 0,
                          minimumSize: Size(100, 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
