import 'dart:convert';

import 'package:flutter_web_dashbard/constants/link.dart';
import 'package:flutter_web_dashbard/models/admin.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  Admin? _admin;
  Admin? get admin => _admin;
  set admin(Admin? data) {
    _admin = data;
    update();
  }

  final bool _isLogin = false;
  bool get isLogin => _isLogin;
  set isLogin(bool data) {
    isLogin = data;
    update();
  }

  Future<void> login(String username, String password) async {
    final http.Response response = await http.post(
      Uri.parse(Link.login),
      body: jsonEncode({
        "username": username,
        "password": password,
      }),
    );

    if (response.statusCode == 200) {
      admin = Admin.fromJson(jsonDecode(response.body));
    }
  }
}
