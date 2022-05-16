
import 'package:finance_portfolio/components/portfolio/block.dart';
import 'package:finance_portfolio/components/portfolio/chart.dart';
import 'package:finance_portfolio/components/portfolio/reusable_functions.dart';
import 'package:finance_portfolio/components/stat_bar.dart';
import 'package:finance_portfolio/components/text/title.dart';
import 'package:finance_portfolio/models/portfolio.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

// ignore: must_be_immutable
class Statistics extends StatefulWidget {
  Statistics({Key? key, this.newTimeScale = ""}) : super(key: key);

  String newTimeScale;

  @override
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  late Future<List<PortfolioModel>> futurePortfolio;


  @override
  Widget build(BuildContext context) {
    final dataStat =
        ModalRoute.of(context)!.settings.arguments as PortfolioModel;
    final data = dataStat;
    return Scaffold(
        backgroundColor: const Color(0xff24242a),
        bottomNavigationBar: const StatBar(),
        body: Padding(
          padding: const EdgeInsets.only(top: 70, left: 25, right: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                decoration: const BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(width: 1, color: Color(0xff2b2e35)))),
                child: Column(
                  children: [
                    Row(
                      children: [
                        InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Padding(
                              padding: EdgeInsets.only(bottom: 18.0),
                              child: Icon(Icons.arrow_back_ios,
                                  color: Colors.white, size: 18),
                            )),
                        const BlockTitle(title: 'Statistic'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              PortfolioBlock(
                chartShow: false,
                name: data.chart!.result![0].meta!.exchangeName!,
                chart: const [],
                title: data.chart!.result![0].meta!.symbol!,
                previous: data.chart!.result![0].meta!.chartPreviousClose!,
                regular: data.chart!.result![0].meta!.regularMarketPrice!,
                currency: data.chart!.result![0].meta!.currency!,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //for (var i in timeScales)
                    TextButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xff353842))),
                        onPressed: () {
                          setState(() {
                            widget.newTimeScale = '';
                          });
                        },
                        child: const Text('', style: TextStyle(fontSize: 12, color: Colors.white ))),
                ],
              ),
              const SizedBox(height: 20),
              StatChart(
                  positive: posOrNeg(
                      data.chart!.result![0].meta!.regularMarketPrice!,
                      data.chart!.result![0].meta!.chartPreviousClose!),
                  data: data.chart!.result![0].indicators!.quote![0].open!
                      .whereNotNull()
                      .toList()
                      .cast<num>()),
              const SizedBox(height: 30),
              _row(
                  'High Price',
                  data.chart!.result![0].indicators!.quote![0].high![0]
                      .toStringAsFixed(2),
                  data.chart!.result![0].meta!.currency!),
              const SizedBox(height: 20),
              _row(
                  'Low Price',
                  data.chart!.result![0].indicators!.quote![0].low![0]
                      .toStringAsFixed(2),
                  data.chart!.result![0].meta!.currency!),
            ],
          ),
        ));
  }
}

Row _row(title, value, String? symbol) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(title, style: const TextStyle(color: Color(0xff6a6d76))),
      Text(symbol! + value, style: const TextStyle(color: Colors.white)),
    ],
  );
}
