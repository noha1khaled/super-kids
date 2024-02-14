import 'package:firebase/login_screen.dart';
import 'package:firebase/main_of_home_screen.dart';
import 'package:firebase/splash_screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/constants.dart';
import 'empty.dart';
import 'firebase_options.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // runApp(const MyApp());

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // final sharedPref = await SharedPreferences.getInstance();
  // Constants.userID = sharedPref.getString('userID');
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  bool isUserLoggedIn = false;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(), builder: (context, snapshot) {
      if (snapshot.hasData) {
        isUserLoggedIn = snapshot.data?.getBool(keepMeLogedIN) ?? false;
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            home:isUserLoggedIn? MainHomeScreen() : SplashScreen());
      }
      else {
        return MaterialApp(
            home:SplashScreen()
            );

      }
    });
  }
}
