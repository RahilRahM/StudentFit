import 'models/user.dart';
import 'package:dio/dio.dart';
import 'utils/userAuthentication.dart';
import 'package:flutter/material.dart';
import 'screens/welcomePages/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';

final dio = Dio();
SharedPreferences? prefs;
User? user;

Future<bool> my_init_app() async {
  prefs = await SharedPreferences.getInstance();
  user = await UserAuthentication.getLoggedUser();
  return true;
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WelcomePage(),
    );
  }
}
