import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fr/view/Chat/ChatsPage.dart';
import 'package:fr/view/CustomWidgets/DraverContent.dart';
import 'package:fr/view/MainPages/ListSellers.dart';
import 'package:fr/view/Profile.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
CollectionReference users = FirebaseFirestore.instance.collection('users');

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50,
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const ChatsPAge()));
              },
              child: const Text('Чат', style: TextStyle(fontWeight: FontWeight.w800, color: Colors.black), ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfilePage()));
              },
              child: const Text('Профиль', style: TextStyle(fontWeight: FontWeight.w800, color: Colors.black)),
            ),
            SelOfBuy(auth.currentUser!.uid),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('AMID'),
        titleTextStyle: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            fontFamily: 'Inter',
            color: Colors.black),
        centerTitle: true,
      ),
      body: const ListSellers(),
    );
  }
}
