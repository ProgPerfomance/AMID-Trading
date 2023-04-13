// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fr/view/Profile.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
TextEditingController _messageController = TextEditingController();

class ChatingScreen extends StatefulWidget {
  final chatname;
  final chatref;
  final uid;
  const ChatingScreen(
      {Key? key,
      required this.chatname,
      required this.chatref,
      required this.uid})
      : super(key: key);

  @override
  State<ChatingScreen> createState() => _ChatingScreenState();
}

class _ChatingScreenState extends State<ChatingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.chatname),
        ),
        floatingActionButton: FloatingActionButton.small(
            onPressed: () {}, child: const Icon(Icons.credit_card_sharp)),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('chats')
                    .doc(widget.chatref)
                    .collection('messages')
                    .orderBy('time', descending: true)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text('ошибка');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Material(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.green,
                        ),
                      ),
                    );
                  }

                  return Flexible(
                      flex: 4,
                      fit: FlexFit.tight,
                      //  height: MediaQuery.of(context).size.height / 1.2,
                      child: ListView.builder(
                          reverse: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            var send = snapshot.data!.docs[index];

                            return GestureDetector(
                                onLongPress: () {
                                  if (send.get('user') ==
                                      auth.currentUser!.displayName) {
                                    showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        content:
                                            const Text('Удалить сообщение?'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () async {
                                              send.reference.delete();
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Удалить'),
                                          ),
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context, 'OK'),
                                            child: const Text('Отмена'),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                },
                                child: Column(
                                  crossAxisAlignment: send.get('user') ==
                                          auth.currentUser!.displayName
                                      ? CrossAxisAlignment.end
                                      : CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          1.5,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 7),
                                        child: Container(
                                          color: Colors.transparent,
                                          child: Column(
                                            crossAxisAlignment:
                                                send.get('user') ==
                                                        auth.currentUser!
                                                            .displayName
                                                    ? CrossAxisAlignment.end
                                                    : CrossAxisAlignment.start,
                                            children: [
                                              Text(send.get('message')),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                send.get('user') ==
                                                        auth.currentUser!
                                                            .displayName
                                                    ? 'Вы'
                                                    : send.get('user'),
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.w900),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                ));
                          }));
                }),
            Expanded(
              child: TextField(
                controller: _messageController,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                  onPressed: () async {
                    String? value = _messageController.text;
                    firebaseFirestore
                        .collection('users')
                        .doc(auth.currentUser!.uid)
                        .collection('chats')
                        .doc(widget.chatref)
                        .set({
                      'chatreference': widget.chatref,
                      'chatname': widget.chatname,
                      'lastmessage': '',
                      'chatimage': '',
                      'ouid': widget.uid,
                    });
                    firebaseFirestore
                        .collection('users')
                        .doc(widget.uid)
                        .collection('chats')
                        .doc(widget.chatref)
                        .set({
                      'chatreference': widget.chatref,
                      'chatname': auth.currentUser!.displayName,
                      'lastmessage': '',
                      'chatimage': '',
                      'ouid': auth.currentUser!.uid,
                    });
                    if (value.isNotEmpty) {
                      firebaseFirestore
                          .collection('chats')
                          .doc(widget.chatref)
                          .collection('messages')
                          .add({
                        'message': _messageController.text,
                        'user': auth.currentUser!.displayName,
                        'time': DateTime.now().microsecondsSinceEpoch,
                      });
                      _messageController.clear();
                      value = null;
                    }
                  },
                  icon: Icon(
                    Icons.mark_email_read_sharp,
                    color: _messageController.text.isNotEmpty
                        ? Colors.cyan
                        : Colors.grey,
                  ),
                )),
              ),
            ),
          ],
        ));
  }
}
