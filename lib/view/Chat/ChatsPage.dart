import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fr/view/Chat/ChatingPage.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

class ChatsPAge extends StatefulWidget {
  const ChatsPAge({Key? key}) : super(key: key);

  @override
  State<ChatsPAge> createState() => _ChatsPAgeState();
}

class _ChatsPAgeState extends State<ChatsPAge> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(auth.currentUser!.uid)
              .collection('chats')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('ошибка');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Material(
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.red,
                  ),
                ),
              );
            }

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 3),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var chats = snapshot.data!.docs[index];
                    return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChatingScreen(
                                        chatref: chats.get('chatreference'),
                                        chatname: chats.get('chatname'),
                                        uid: chats.get('ouid'),
                                      )));
                        },
                        child: Card(
                          color: Colors.white70,
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 30,
                              ),
                              Column(
                                children: [
                                  Text(
                                    chats.get('chatname'),
                                  ),
                                  Text(
                                    chats.get('lastmessage'),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ));
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
