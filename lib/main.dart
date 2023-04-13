// ignore_for_file: avoid_print

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fr/firebase/auth/auth_controller.dart';
import 'package:fr/view/HomePage.dart';
import 'package:fr/view/Profile.dart';
import 'package:fr/view/auth/GoogleLoginPage.dart';
import 'package:fr/view/auth/Landing.dart';
import 'package:fr/view/auth/RegestrationUser.dart';
import 'package:fr/view/auth/RegisterSeller.dart';
import 'package:fr/view/auth/SellerGoogleAuthPage.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Color.fromRGBO(67, 187, 122, 1),
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) => print("Firebase Initialized"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      theme: ThemeData(
          appBarTheme:
              AppBarTheme(backgroundColor: Color.fromRGBO(67, 187, 122, 1))),
      // themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        stream: AuthController().authChanges,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            return const HomePage();
          }
          return const Landing();
        },
      ),
      routes: {
        'home_page': (context) => const HomePage(),
        //    "phone_login_page": (context) => const PhoneLoginPage(),
        "google_login_page": (context) => const GoogleLoginPage(),
        "google_seller_login_page": (context) => const SellerGoogleLoginPage(),
        "profile_page": (context) => const ProfilePage(),
        "landing": (context) => const Landing(),
        "reg_seller": (context) => const RegestrationSeller(),
        "reg_buyer": (context) => const RegestrationUser(),
      },
    );
  }
}
