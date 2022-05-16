import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

class Header extends StatefulWidget {
  const Header({Key? key, required this.balance}) : super(key: key);
  final String balance;

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(width: 1, color: Color(0xff2b2e35)))),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Current balance',
                    style: TextStyle(fontSize: 16, color: Color(0xff7e828b))),
                Row(
                  children: const [
                    Icon(UniconsLine.qrcode_scan, color: Color(0xffe1e0e1)),
                    SizedBox(width: 30),
                    Icon(UniconsLine.bell, color: Color(0xffe1e0e1)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text('\$${widget.balance}',
                    style: const TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold))
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
