import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fr/view/ProfileSeller.dart';


class NotSortingSellersList extends StatefulWidget {
  const NotSortingSellersList({Key? key}) : super(key: key);

  @override
  State<NotSortingSellersList> createState() => _NotSortingSellersListState();
}

class _NotSortingSellersListState extends State<NotSortingSellersList> {
  @override
  Widget build(BuildContext context) {
    return  StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('sellers')
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('жопа');
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

          return Flexible(
              child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var sellers = snapshot.data!.docs[index];

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfileSellerPage(
                                  username: sellers.get('username'),
                                  rating: sellers.get('rating'),
                                  region: sellers.get('region'),
                                  uids: sellers.get('uid'),
                                )));
                      },
                      child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Container(
                              height: 30,
                              decoration: BoxDecoration(
                                border: Border.all(),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(sellers.get('username')),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(sellers.get('region')),
                                      SizedBox(
                                        width: MediaQuery.of(context)
                                            .size
                                            .width /
                                            5,
                                      ),
                                      Text(sellers.get('rating')),
                                    ],
                                  )
                                ],
                              ))),
                    );
                  }));
        }); //конец раздела продавцов;
  }
}


class SortingSellersList extends StatefulWidget {
  const SortingSellersList({Key? key}) : super(key: key);

  @override
  State<SortingSellersList> createState() => _SortingSellersListState();
}

class _SortingSellersListState extends State<SortingSellersList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('sellers')
            .orderBy('rating', descending: true)
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('жопа');
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

          return Flexible(
              child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var sellers = snapshot.data!.docs[index];

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfileSellerPage(
                                  username: sellers.get('username'),
                                  rating: sellers.get('rating'),
                                  region: sellers.get('region'),
                                  uids: sellers.get('uid'),
                                )));
                      },
                      child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Container(
                              height: 30,
                              decoration: BoxDecoration(
                                border: Border.all(),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(sellers.get('username')),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(sellers.get('region')),
                                      SizedBox(
                                        width: MediaQuery.of(context)
                                            .size
                                            .width /
                                            5,
                                      ),
                                      Text(sellers.get('rating')),
                                    ],
                                  )
                                ],
                              ))),
                    );
                  }));
        });
  }
}
