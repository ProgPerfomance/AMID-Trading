import 'package:flutter/material.dart';

class Landing extends StatefulWidget {
  const Landing({Key? key}) : super(key: key);

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Text(
            'Log in as',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "reg_seller");
                  },
                  child: const Text(
                    'seller',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                  )),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "reg_buyer");
                  },
                  child: const Text(
                    'buyer',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                  )),
            ],
          ),
          SizedBox(
            height: 35,
          )
        ],
      ),
    );
  }
}
