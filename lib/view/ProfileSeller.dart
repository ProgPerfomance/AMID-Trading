// ignore_for_file: use_build_context_synchronously
import 'dart:core';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fr/view/CustomWidgets/GetUserName.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
class ProfileSellerPage extends StatefulWidget {
  final username;
  final rating;
  final region;
  final uids;
  const ProfileSellerPage({Key? key,required this.region,required this.rating,required this.username, required this.uids}) : super(key: key);

  @override
  State<ProfileSellerPage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfileSellerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(
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
                  Text(widget.username),
                ],
              ),
              Text('Регион: ${widget.region}'),
              Text('Рейтинг: ${widget.rating}'),
              ChatOrNull(documentId: auth.currentUser!.uid, username: widget.username, uids: widget.uids,),
            ],
          ),
        ));
  }
}
