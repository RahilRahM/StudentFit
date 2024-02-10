import 'models/user.dart';
import 'package:dio/dio.dart';
import 'utils/userAuthentication.dart';
import 'package:flutter/material.dart';
import 'screens/welcomePages/welcome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:StudentFit/screens/home/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

final dio = Dio();
SharedPreferences? prefs;
User? user;

Future<void> initializeFirebaseAndPreferences() async {
  await Firebase.initializeApp();
  prefs = await SharedPreferences.getInstance();
}

Future<void> my_init_app() async {
  user = await UserAuthentication.getLoggedUser();

  if (user != null) {
    String result = await UserAuthentication.getUserInfo(user!.uid);
    if (result != 'success') {
      print('Failed to fetch user info: $result');
    } else {
      await prefs!.setBool('isLoggedIn', true);
    }
  }

  // Optional: Print out all SharedPreferences data for debugging
  Set<String> keys = prefs!.getKeys();
  for (String key in keys) {
    print(' $key : ${prefs!.get(key)}');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeFirebaseAndPreferences();
  await my_init_app();
  runApp(MaterialApp(
    home: prefs!.getBool('isLoggedIn') ?? false ? HomePage(appBarTitle: 'Home') : MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WelcomePage(),
    );
  }
}
