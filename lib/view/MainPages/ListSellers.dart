// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fr/view/CustomWidgets/AnketWidget.dart';
import 'package:fr/view/CustomWidgets/SortSellers.dart';
import 'package:fr/view/MainPages/ListFreeOrders.dart';
bool sort = false; //сортировка по рейтингу вкл/выкл
// сортировка по рейтингу виджет вкл/выкл
final FirebaseAuth auth = FirebaseAuth.instance;

class ListSellers extends StatefulWidget {
  const ListSellers({Key? key}) : super(key: key);

  @override
  State<ListSellers> createState() => _HomePageState();
}

class _HomePageState extends State<ListSellers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        SizedBox(height: 13,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Имя',
                style: TextStyle(fontSize: 17),
              ),
              const SizedBox(
                width: 10,
              ),
              const Text(
                'Регион',
                style: TextStyle(fontSize: 17),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (sort == false) {
                      sort = true;
                    }
                    else {
                      sort = false;
                    }
                  });

                },
                child: Text(
                  'Рейтинг',
                  style: TextStyle(fontSize: 17, color: sort == false ? Colors.black : Colors.green),
                ),
              )

            ],
          ),
        ),
        SizedBox(height: 10,),
        sort == false ? NotSortingSellersList() : SortingSellersList(),
        Container(
          //начало раздела анкет
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('ankets').snapshots(),
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
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 5,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          var anketss = snapshot.data!.docs[index];
                          return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AnketWidget(
                                              brand: anketss.get('brand'),
                                              productBrand:
                                                  anketss.get('productBrand'),
                                              productName:
                                                  anketss.get('productName'),
                                              uid: '',
                                            )));
                              },
                              child: Card(
                                child: Column(
                                  children: [
                                    const Image(
                                      image: NetworkImage(
                                          'https://myalpins.com/1686-thickbox_default/nike-air-jordan-1-mid-%D0%B4%D1%8B%D0%BC%D1%87%D0%B0%D1%82%D1%8B%D0%B9-%D1%81%D0%B5%D1%80%D1%8B%D0%B9.jpg'),
                                      height: 75,
                                      width: 75,
                                    ),
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
                                        Text('${anketss.get('productBrand')}'),
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
                              ));
                        }),
                  ));
            },
          ),
        ),
        Flexible(
            flex: 0,
            child: TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ListFreeOrders()));
                },
                child: const Text(
                  'Развернуть...',
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ))),
      ],
    ));
  }
}
