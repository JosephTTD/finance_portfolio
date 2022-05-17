import 'package:flutter/material.dart';

import '../text/title.dart';

class StatAppBar extends StatefulWidget {
  const StatAppBar({Key? key}) : super(key: key);

  @override
  State<StatAppBar> createState() => _StatAppBarState();
}

class _StatAppBarState extends State<StatAppBar> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.only(left: 25, right: 25, top: height * 0.07),
      child: Container(
        decoration: const BoxDecoration(
            border:
                Border(bottom: BorderSide(width: 1, color: Color(0xff2b2e35)))),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.arrow_back_ios,
                    color: Colors.white, size: 18),
              ),
              const BlockTitle(title: 'Statistic'),
              const SizedBox(width: 10),
            ],
          ),
        ),
      ),
    );
  }
}
