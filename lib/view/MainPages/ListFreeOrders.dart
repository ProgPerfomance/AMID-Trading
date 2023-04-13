import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fr/view/CustomWidgets/AnketWidget.dart';

class ListFreeOrders extends StatefulWidget {
  const ListFreeOrders({Key? key}) : super(key: key);

  @override
  State<ListFreeOrders> createState() => _ListFreeOrdersState();
}

class _ListFreeOrdersState extends State<ListFreeOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('ankets').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('легло (читай доку)');
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

            return Container(
              height: MediaQuery.of(context).size.height / 1.7,
              child: GridView.builder(

              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                  itemCount: snapshot.data!.docs.length,

                   itemBuilder: (context, index) {
                     var anketss = snapshot.data!.docs[index];
                     return GestureDetector(
                         onTap: () {
                       Navigator.push(context, MaterialPageRoute(builder: (context) => AnketWidget(brand: anketss.get('brand'), productBrand: anketss.get('productBrand'), productName: anketss.get('productName'), uid: '',)));
                     },
                     child:
                       Card(
                       child: Column(
                         children: [
                           Image(
                             image: NetworkImage(
                                 'https://myalpins.com/1686-thickbox_default/nike-air-jordan-1-mid-%D0%B4%D1%8B%D0%BC%D1%87%D0%B0%D1%82%D1%8B%D0%B9-%D1%81%D0%B5%D1%80%D1%8B%D0%B9.jpg'),
                             height: 70,
                             width: 70,
                           ),
                           Row(
                             children: [
                               const Text(
                                 'Бренд: ',
                                 style: TextStyle(
                                     color: Colors.amber, fontSize: 13),
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
                                     fontSize: 13),
                               ),
                               Text('${anketss.get('productBrand')}'),
                             ],
                           ),
                           Row(
                             children: [
                               const Text(
                                 'Модель: ',
                                 style: TextStyle(
                                     color: Colors.purple, fontSize: 13),
                               ),
                               Text('${anketss.get('productName')}'),
                             ],
                           ),
                         ],
                       ),
                     ));
                   }),
            );
          },
        ),
      ),
    );
  }
}
