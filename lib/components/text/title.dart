import 'package:flutter/material.dart';

class BlockTitle extends StatefulWidget {
  const BlockTitle({ Key? key, required this.title }) : super(key: key);

  final String title;

  @override
  State<BlockTitle> createState() => _BlockTitleState();
}

class _BlockTitleState extends State<BlockTitle> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0.0),
      child: Row(
        children: [
          Text(
            widget.title,
            style: const TextStyle(fontSize: 20, color: Colors.white ),
          ),
        ],
      ),
    );
  }
}