// To parse this JSON data, do
//
//     final customUser = customUserFromJson(jsonString);

import 'dart:convert';

List<CustomUser> customUserFromJson(String str) => List<CustomUser>.from(json.decode(str).map((x) => CustomUser.fromJson(x)));

String customUserToJson(List<CustomUser> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CustomUser {
    CustomUser({
        this.email,
        this.fullname,
        this.phone,
        this.password,
    });

    String ?email;
    String ?fullname;
    String ?phone;
    String ?password;

    factory CustomUser.fromJson(Map<String, dynamic> json) => CustomUser(
        email: json["email"],
        fullname: json["fullname"],
        phone: json["phone"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "fullname": fullname,
        "phone": phone,
        "password": password,
    };
}
