import 'package:flutter/material.dart';

class MessageTileWidget extends StatefulWidget {
  final msg;
  final sender;
  const MessageTileWidget({Key? key, required this.sender, required this.msg}) : super(key: key);

  @override
  State<MessageTileWidget> createState() => _MessageTileWidgetState();
}

class _MessageTileWidgetState extends State<MessageTileWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(widget.msg),
        Text(widget.sender),
      ],
    );
  }
}
