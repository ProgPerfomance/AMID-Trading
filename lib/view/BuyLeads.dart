import 'package:flutter/material.dart';

double _sliderCurrent = 0;
int _sliderText = 0;

class BuyLeads extends StatefulWidget {
  const BuyLeads({Key? key}) : super(key: key);

  @override
  State<BuyLeads> createState() => _BuyLeadsState();
}

class _BuyLeadsState extends State<BuyLeads> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buy leads'), centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Slider(
              value: _sliderCurrent,
              max: 100,
              divisions: 100,
              label: _sliderCurrent.round().toString(),
              onChanged: (double value) {
                setState(() {
                  _sliderCurrent = value;
                  _sliderText = value.toInt();
                });
              }),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Quantity: ', style: TextStyle(fontSize: 17, color: Colors.black54),),
              Text(_sliderText.toString(), style: const TextStyle(fontSize: 18),),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Price: ', style: TextStyle(fontSize: 17, color: Colors.black54),),
              Text((_sliderText * 100).toString(), style: const TextStyle(fontSize: 18),),
            ],
          ),
          SizedBox(height: 50,),
          TextButton(onPressed: () {}, child: const Text('Buy!', style: TextStyle(color: Colors.black54),), style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),),
        ],
      ),
    );
  }
}
