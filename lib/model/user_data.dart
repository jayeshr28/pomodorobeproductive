class UserData {
  String name, gender;

  UserData({required this.name, required this.gender});

  UserData.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        gender = json['gender'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'gender': gender,
      };
}
