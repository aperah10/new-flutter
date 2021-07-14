import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CustomUserLoginRespo {
  static String mainUrl = "https://reqres.in";
  var loginUrl = '$mainUrl/api/login';

  // STORAGE FOR TOKEN DATA
  final FlutterSecureStorage storage = new FlutterSecureStorage();

  // 1. ======TOKEN HAS TOKEN
  Future<bool> hasToken() async {
    var value = await storage.read(key: 'usertoken');
    print('this is token ${value}');
    if (value != null) {
      return true;
    } else {
      return false;
    }
  }

  // 2. ======== TOKEN PERSISTIT
  Future<void> persistToken(String usertoken) async {
    await storage.write(key: 'usertoken', value: usertoken);
  }

  // 3. ======= TOKEN DELETE ==========
  Future<void> deleteToken() async {
    storage.delete(key: 'usertoken');
    storage.deleteAll();
  }

  // LOGIN PAGE
  Future<String> loginnow(String phone, String password) async {
    // String Baseurl = "https://reqres.in/api/login";
    try {
      var res = await http.post(
        Uri.parse(loginUrl),
        // body: jsonEncode(res),
        body: {
          "email": phone,
          "password": password,
        },
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
        },
      );
      
      if (res.statusCode == 200) {
        return "success";
      }
      if (res.statusCode == 404) {
        return "not Valid ";
      } else {
        print(res.body);
        // server error
        return "err";
      }
    } catch (SocketException) {
      // fetching error
      return "err ${SocketException}";
    }
  }

  // // 2.   SIGNUP PAGE ========================
  // Future<bool> registernow(
  //     String email, String phone, String fullname, String password) async {
  //   String Baseurl = "https://reqres.in/api/register";
  //   try {
  //     var res = await http.post(Uri.parse(Baseurl),
  //         headers: {
  //           "Content-Type": "application/json",
  //         },
  //         body: json.encode({
  //           "email": email,
  //           "fullname": fullname,
  //           "phone": phone,
  //           "password": password
  //         }));

  //     var data = json.decode(res.body) as Map;
  //     print(data);
  //     if (data["error"] == false) {
  //       return true;
  //     }
  //     return false;
  //   } catch (e) {
  //     print("e loginNow");
  //     print(e);
  //     return false;
  //   }
  // }
}
