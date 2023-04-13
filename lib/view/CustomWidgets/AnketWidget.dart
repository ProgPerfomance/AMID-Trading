import 'package:flutter/material.dart';


class AnketWidget extends StatefulWidget {
  final uid;
  final brand;
  final productBrand;
  final productName;
  const AnketWidget({Key? key, required this.uid, required this.brand, required this.productBrand, required this.productName}) : super(key: key);

  @override
  State<AnketWidget> createState() => _AnketWidgetState();
}

class _AnketWidgetState extends State<AnketWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
        Center(child:
      Column(
        mainAxisAlignment:
        MainAxisAlignment.center,
        children: [
          Image(image: NetworkImage('https://baden.ru/upload/resize_cache/iblock/4ad/500_500_1/ulkvmq26mxl6yyl2fqk92mjp9g1qmp6m.jpg')),
          SizedBox(height: 25,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Бренд: ',
                style: TextStyle(
                    color: Colors.amber,
                    fontSize: 23),
              ),
              Text(widget.brand, style: TextStyle(
                fontSize: 20
              ),),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Марка: ',
                style: TextStyle(
                    color: Colors.lightGreen,
                    fontSize: 23),
              ),
              Text(widget.productBrand,style: TextStyle(
                  fontSize: 20
              ),),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Модель: ',
                style: TextStyle(
                    color: Colors.purple,
                    fontSize: 20),
              ),
              Text(widget.productName,style: TextStyle(
                  fontSize: 20
              ),),
            ],
          ),
        ],
      ),
    )
    );
  }
}
