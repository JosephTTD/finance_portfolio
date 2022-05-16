import 'package:finance_portfolio/components/portfolio/chart.dart';
import 'package:finance_portfolio/components/portfolio/reusable_functions.dart';
import 'package:flutter/material.dart';

class PortfolioBlock extends StatefulWidget {
  const PortfolioBlock(
      {Key? key,
      required this.title,
      required this.regular,
      required this.previous,
      required this.chartShow,
      required this.currency,
      required this.name,
      required this.chart})
      : super(key: key);

  final String title;
  final double regular;
  final double previous;
  final String currency;
  final bool chartShow;
  final String? name;
  final List<dynamic>? chart;
  //final List chart;

  @override
  State<PortfolioBlock> createState() => _PortfolioBlockState();
}

class _PortfolioBlockState extends State<PortfolioBlock> {
  Text diff(num1, num2) {
    if (num1 > num2) {
      return Text('+${(num1 - num2).toStringAsFixed(2)}%',
          style: const TextStyle(
              color: Color(0xff406e56), fontWeight: FontWeight.bold));
    } else {
      return Text('-${(num2 - num1).toStringAsFixed(2)}%',
          style: const TextStyle(
              color: Color(0xff9e3f4f), fontWeight: FontWeight.bold));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(
            children: [
              Container(
                  height: 50,
                  width: 50,
                  decoration: const BoxDecoration(
                      color: Color(0xff353842),
                      borderRadius: BorderRadius.all(Radius.circular(9))),
                  child: Center(
                    child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            color: const Color(0xff353842),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 2,
                                blurRadius: 7,
                                offset: const Offset(
                                    0, 5), // changes position of shadow
                              ),
                            ],
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20))),
                        child: Center(
                          child: Text(
                              widget.title.isNotEmpty ? widget.title[0] : 'NA',
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        )),
                  )),
              const SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.title,
                      style: const TextStyle(color: Colors.white)),
                  Text(
                    widget.name ?? '',
                    style:
                        const TextStyle(fontSize: 12, color: Color(0xff65666f)),
                  )
                ],
              ),
            ],
          ),
          if (widget.chartShow == true)
            SizedBox(
              height: 23,
              width: 120,
              child: StatChart(
                  positive: posOrNeg(widget.regular, widget.previous),
                  data: widget.chart as List<num>),
            )
          else
            const SizedBox(
              width: 120,
            ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(widget.currency + widget.regular.toStringAsFixed(2),
                  style: const TextStyle(color: Colors.white)),
              diff(widget.regular, widget.previous)
            ],
          ),
        ]),
        const SizedBox(height: 25)
      ],
    );
  }
}
