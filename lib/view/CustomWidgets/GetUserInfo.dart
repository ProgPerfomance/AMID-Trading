import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

CollectionReference users = FirebaseFirestore.instance.collection('users');
final FirebaseAuth auth = FirebaseAuth.instance;

class GetUserInfo extends StatelessWidget {
  final String documentId;

  GetUserInfo(this.documentId);

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
          snapshot.data!.data() as Map<String, dynamic>;
          return Text(
            "${data['userinfo']}",
            style: const TextStyle(fontSize: 21.3),
          );
        }

        return const Text("loading");
      },
    );
  }
}

CollectionReference sellers = FirebaseFirestore.instance.collection('sellers');

class GetSellerName extends StatelessWidget {
  final String documentId;

  GetSellerName(this.documentId);

  @override
  Widget build(BuildContext context) {
    CollectionReference users =
    FirebaseFirestore.instance.collection('sellers');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
          snapshot.data!.data() as Map<String, dynamic>;
          return Text(
            "${data['firstname']}",
            style: const TextStyle(fontSize: 21.3),
          );
        }

        return const Text("loading");
      },
    );
  }
}
