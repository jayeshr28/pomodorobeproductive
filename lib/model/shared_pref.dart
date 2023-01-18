import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static Future<String> getStringName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String name = prefs.getString('user')!;
    return name;
  }

  static Future<String> getStringGender() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String gender = prefs.getString('gender')!;
    return gender;
  }

  static Future<dynamic> getHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> taskName = prefs.getStringList('taskList')!;
    List<String> taskDuration = prefs.getStringList('timeElapsed')!;

    return {"taskName": taskName, "taskDuration": taskDuration};
  }
}
