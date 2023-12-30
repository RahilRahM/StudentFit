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

  if (user != null) {
    String result = await UserAuthentication.getUserInfo(user!.uid);
    if (result != 'success') {
      print('Failed to fetch user info: $result');
    }
  }

  if (prefs != null) {
    Set<String> keys = prefs!.getKeys();
    for (String key in keys) {
      print(' $key : ${prefs!.get(key)}');
    }
  }

  return true;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await my_init_app();
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
