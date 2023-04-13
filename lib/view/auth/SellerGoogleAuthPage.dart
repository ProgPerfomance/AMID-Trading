// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:fr/firebase/auth/seller_auth_controller.dart';

final SellerAuthController _authController = SellerAuthController();

class SellerGoogleLoginPage extends StatefulWidget {
  const SellerGoogleLoginPage({Key? key}) : super(key: key);

  @override
  State<SellerGoogleLoginPage> createState() => _GoogleLoginPageState();
}

class _GoogleLoginPageState extends State<SellerGoogleLoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Auth seller with Google'), centerTitle: true,
      ),
      body: Column(
        children: [
          TextButton(
              onPressed: () async {
                String res = await _authController.signInWithGoogle();
                if (res == "success") {
                  Navigator.pushNamedAndRemoveUntil(
                      context, "home_page", (route) => false);
                }
              },
              child: const Text('Auth')),
        ],
      ),
    );
  }
}
