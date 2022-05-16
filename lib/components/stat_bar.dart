import 'package:flutter/material.dart';

class StatBar extends StatefulWidget {
  const StatBar({Key? key, this.sell, this.buy}) : super(key: key);

  final bool? sell;
  final dynamic buy;

  @override
  State<StatBar> createState() => _StatBarState();
}

class _StatBarState extends State<StatBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff272a34),
      child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 20, 30, 30),
          child: Row(
            children: [
             Flexible(
                child: TextButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      )),
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.only(top: 14, bottom: 14)),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xff353842))),
                  onPressed: () {
                    if(widget.sell != true) {
                      setState(() {
                        Navigator.pop(context);
                      });
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                      const SizedBox(width: 7),
                      Text(
                        widget.sell == true ? 'Sell' : "Close",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Flexible(
                child: TextButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      )),
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.only(top: 14, bottom: 14)),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xffd48154))),
                  onPressed: () {
                    setState(() {
                      widget.buy;
                      Navigator.pop(context);
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      SizedBox(width: 7),
                      Text(
                        'Buy',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
