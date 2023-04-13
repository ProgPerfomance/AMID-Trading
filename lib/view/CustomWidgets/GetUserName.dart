import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fr/view/AnketeFree.dart';
import 'package:fr/view/BuyLeads.dart';
import 'package:fr/view/Chat/ChatingPage.dart';
import 'package:fr/view/MyAnkets.dart';

CollectionReference users = FirebaseFirestore.instance.collection('users');
final FirebaseAuth auth = FirebaseAuth.instance;

class GetUserName extends StatelessWidget {
  final String documentId;

  GetUserName(this.documentId);

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
            "${data['username']}",
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


class SelLeand extends StatelessWidget {
  final String documentId;

  SelLeand(this.documentId);

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
          if (data['seller'] == true) {
            return TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const BuyLeads()));
                },
                child: const Text('Купить лиды'));
          } else {
            return Column(
              children: [
                TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black)),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AnketeFreeOrder()));
                  },
                  child: const Text(
                    'Создать анкету',
                    style: TextStyle(fontSize: 17, color: Colors.white),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const MyAnkets()));
                  },
                  child: const Text(
                    'Мои анкеты',
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black)),
                ),
              ],
            );
          }
        }
        return const Text('');
      },
    );
  }
}

class ChatOrNull extends StatelessWidget {
  final String documentId;
  final uids;
  final username;
  ChatOrNull(
      {required this.documentId, required this.uids, required this.username});

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
          if (data['seller'] == true) {
            return Container();
          } else {
            return TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChatingScreen(
                                chatref: auth.currentUser!.uid + uids,
                                chatname: username,
                                uid: uids,
                              )));
                },
                child: const Text('Перейти к чату'));
          }
        }
        return const Text('');
      },
    );
  }
}
