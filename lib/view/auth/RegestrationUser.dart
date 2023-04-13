// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:fr/firebase/auth/auth_controller.dart';
import 'package:fr/firebase/auth/email_auth_controller.dart';
import 'package:fr/view/HomePage.dart';

EmailAuthController _emailAuthController = EmailAuthController();
final AuthController _authController = AuthController();

class RegestrationUser extends StatefulWidget {
  const RegestrationUser({Key? key}) : super(key: key);

  @override
  State<RegestrationUser> createState() => _LoginPageState();
}

class _LoginPageState extends State<RegestrationUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'AMID',
            style: TextStyle(
                fontWeight: FontWeight.w900, fontSize: 55, color: Colors.black),
          ),
          Container(width: MediaQuery.of(context).size.width /2.3, height: 10, color: Colors.black,),
          SizedBox(
            height: MediaQuery.of(context).size.height / 3.5,
          ),
          TextButton(
            onPressed: () async {
              await _emailAuthController.signInWithEmail();
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.black),
              padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 10)),
            ),
            child: const Text(
              'Авторизация через телефон',
              style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w800,
                  color: Colors.white),
            ),
          ),
          const SizedBox(
            height: 35,
          ),
          TextButton(
              onPressed: () async {
                String res = await _authController.signInWithGoogle();
                if (res == "success") {
                  Navigator.pushNamedAndRemoveUntil(
                      context, "home_page", (route) => false);
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black),
                padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10)),
              ),
              child: const Text(
                'Авторизация через Google',
                style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w800,
                    color: Colors.white),
              )),
        ],
      ),
    ));
  }
}
