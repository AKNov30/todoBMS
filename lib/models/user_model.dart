import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(jsonDecode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  int userId;
  String userEmail;
  String userPassword;
  String userFname;
  String userLname;

  UserModel({required this.userId, required this.userEmail, required this.userPassword, required this.userFname, required this.userLname});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    userId: json["user_id"],
    userEmail: json["user_email"],
    userPassword: json["user_password"],
    userFname: json["user_fname"],
    userLname: json["user_lname"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "user_email": userEmail,
    "user_password": userPassword,
    "user_fname": userFname,
    "user_lname": userLname,
  };
}
