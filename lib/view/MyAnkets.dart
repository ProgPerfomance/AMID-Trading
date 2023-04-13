import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fr/view/CustomWidgets/AnketWidget.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

class MyAnkets extends StatefulWidget {
  const MyAnkets({Key? key}) : super(key: key);

  @override
  State<MyAnkets> createState() => _MyAnketsState();
}

class _MyAnketsState extends State<MyAnkets> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Мои анкеты'),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(auth.currentUser!.uid)
              .collection("ankets")
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('смешная ошбка');
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

            return SizedBox(
              height: MediaQuery.of(context).size.height / 1.7,
              child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var anketss = snapshot.data!.docs[index];
                    return GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => AnketWidget(brand: anketss.get('brand'), productBrand: anketss.get('productBrand'), productName: anketss.get('productName'), uid: '',)));
                        },
                        child: Card(
                          child: Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Text(
                                            'Бренд: ',
                                            style: TextStyle(
                                                color: Colors.amber,
                                                fontSize: 16),
                                          ),
                                          Text('${anketss.get('brand')}'),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            'Марка: ',
                                            style: TextStyle(
                                                color: Colors.lightGreen,
                                                fontSize: 16),
                                          ),
                                          Text(
                                              '${anketss.get('productBrand')}'),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            'Модель: ',
                                            style: TextStyle(
                                                color: Colors.purple,
                                                fontSize: 16),
                                          ),
                                          Text('${anketss.get('productName')}'),
                                        ],
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        anketss.reference.delete();
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      )),
                                ],
                              )),
                        ));
                  }),
            );
          }),
    );
  }
}
