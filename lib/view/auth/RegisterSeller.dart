// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fr/firebase/auth/seller_auth_controller.dart';
import 'package:fr/view/HomePage.dart';
final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final SellerAuthController _authController = SellerAuthController();

class RegestrationSeller extends StatefulWidget {
  const RegestrationSeller({Key? key}) : super(key: key);

  @override
  State<RegestrationSeller> createState() => _LoginPageState();
}

class _LoginPageState extends State<RegestrationSeller> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {

                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black),
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10)),
                ),
                child: const Text(
                  'Phone auth',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
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
                    'Google auth',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                  )),
            ],
          ),
        ));
  }
}
