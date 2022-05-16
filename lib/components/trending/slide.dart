import 'package:flutter/material.dart';

class TrendingSlide extends StatefulWidget {
  const TrendingSlide({Key? key, required this.quote}) : super(key: key);

  final String quote;

  @override
  State<TrendingSlide> createState() => _TrendingSlideState();
}

class _TrendingSlideState extends State<TrendingSlide> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 125,
          decoration: const BoxDecoration(
              color: Color(0xff353842),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Container(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 14),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                    Container(
                      height: 30,
                      width: 30,
                        decoration: BoxDecoration(
                            color:const  Color(0xff353842),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 2,
                                blurRadius: 7,
                                offset:
                                    const Offset(0, 5), // changes position of shadow
                              ),
                            ],
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20))),
                        child: Center(
                          child: Text(widget.quote[0],
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                        )),
                      const SizedBox(width: 10),
                      Flexible(
                        flex: 1,
                        child: Text(widget.quote,
                            style: const TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ]),
          ),
        ),
        const SizedBox(width: 15),
      ],
    );
  }
}
