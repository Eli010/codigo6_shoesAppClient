// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.email,
    required this.name,
    required this.phone,
    required this.rol,
  });

  String email;
  String name;
  String phone;
  String rol;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        email: json["email"],
        name: json["name"],
        phone: json["phone"],
        rol: json["rol"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "name": name,
        "phone": phone,
        "rol": rol,
      };
}
