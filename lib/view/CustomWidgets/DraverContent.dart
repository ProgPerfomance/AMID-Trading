import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fr/view/AnketeFree.dart';

class SelOfBuy extends StatelessWidget {
  final String documentId;

  SelOfBuy(this.documentId);

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
          if (data['seller'] == false) {
            return TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AnketeFreeOrder()));
              },
              child: const Text('Создать анкету', style: TextStyle(fontWeight: FontWeight.w800, color: Colors.black)),
            );
          } else {
            return Container();
          }
        }
        return const Text('');
      },
    );
  }
}