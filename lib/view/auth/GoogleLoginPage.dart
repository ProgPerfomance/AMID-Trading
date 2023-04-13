// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:fr/firebase/auth/auth_controller.dart';

final AuthController _authController = AuthController();


class GoogleLoginPage extends StatefulWidget {
  const GoogleLoginPage({Key? key}) : super(key: key);

  @override
  State<GoogleLoginPage> createState() => _GoogleLoginPageState();
}

class _GoogleLoginPageState extends State<GoogleLoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Auth buyer with Google'), centerTitle: true,
      ),
      body: Column(
        children: [

        ],
      ),
    );
  }
}
