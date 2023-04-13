// ignore_for_file: use_build_context_synchronously

import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fr/firebase/auth/auth_controller.dart';
import 'package:fr/view/CustomWidgets/GetUserName.dart';

final storageRef = FirebaseStorage.instance.ref();
final FirebaseAuth auth = FirebaseAuth.instance;

final imagesRef = storageRef.child("/msg-1618008798-1017.jpg");
final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
final AuthController _authController = AuthController();
final name = _authController.user!.displayName.toString();
String UID = _authController.user!.uid.toString();
final TextEditingController _nameAlertController = TextEditingController();
var n = firebaseFirestore.collection('users').doc(auth.currentUser!.uid);
CollectionReference users = FirebaseFirestore.instance.collection('users');

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: CircleAvatar(
                    radius: 43,
                    backgroundImage: NetworkImage(
                        'https://avatars.dzeninfra.ru/get-zen_doc/34175/pub_5cea2361585c2f00b5c9cb0b_5cea310a752e5b00b25b9c01/scale_1200'),
                  )),
              Row(
                children: [
                  GetUserName(auth.currentUser!.uid),
                 IconButton( //смена имени
                      onPressed: () {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Изменить имя'),
                            actions: <Widget>[
                              TextField(
                                decoration: const InputDecoration(
                                    hintText: 'Введите имя'),
                                controller: _nameAlertController,
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() {});
                                  firebaseFirestore
                                      .collection('users')
                                      .doc(auth.currentUser!.uid)
                                      .update({
                                    'username': _nameAlertController.text
                                  });
                                  //    firebaseFirestore.collection('sellers').doc(auth.currentUser!.uid).update({'username': _nameAlertController.text});
                                  _nameAlertController.clear();
                                  Navigator.pop(context);
                                },
                                child: const Text('Изменить'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Отмена'),
                              ),
                            ],
                          ),
                        );
                      },
                      icon: const Icon(Icons.edit)),//смена имени конец
                ],
              ),
            ],
          ),
  Text('Здесь будет инфо о пользователе'),
  //        GetUserInfo(auth.currentUser!.uid),
          SelLeand(auth.currentUser!.uid),
          TextButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushNamedAndRemoveUntil(
                  context, 'landing', (route) => false);
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black)),
            child: const Text(
              'Выйти',
              style: TextStyle(fontSize: 19, color: Colors.red),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    ));
  }
}
