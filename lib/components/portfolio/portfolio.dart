import 'dart:async';
import 'package:finance_portfolio/components/portfolio/block.dart';
import 'package:finance_portfolio/components/portfolio/chart.dart';
import 'package:finance_portfolio/components/portfolio/reusable_functions.dart';
import 'package:finance_portfolio/components/text/title.dart';
import 'package:finance_portfolio/api/api.dart';
import 'package:finance_portfolio/models/portfolio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';
import 'package:collection/collection.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:unicons/unicons.dart';
import '../stat_bar.dart';

class Portfolio extends StatefulWidget {
  const Portfolio({
    Key? key,
  }) : super(key: key);

  @override
  State<Portfolio> createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio> {
  List<List<dynamic>> _data = [];
  late Future<List<PortfolioModel>> futurePortfolio;
  late String activeTime = '';
  late dynamic selected = [];
  Timer? timer;

  void _loadCSV() async {
    final _rawData = await rootBundle.loadString("assets/nyse.csv");
    List<List<dynamic>> _listData =
        const CsvToListConverter().convert(_rawData);
    List _filterList = _listData;
    setState(() {
      _data = _filterList as List<List<dynamic>>;
    });
  }

  _fetchPortfolio({String number = '', List list = const []}) {
    setState(() {
      futurePortfolio = fetchPortfolio(interval: number, ticker: list);
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchPortfolio();
    _loadCSV();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _blockList();
  }

  Widget _blockList() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const BlockTitle(title: 'My portfolio'),
              GestureDetector(
                onTap: () {
                  portfolioModal();
                },
                child: Container(
                    padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(60)),
                    ),
                    child: Row(
                      children: const [
                        Icon(UniconsLine.panel_add,
                            color: Colors.black, size: 17),
                        SizedBox(width: 5),
                        Text(
                          'ADD',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    )),
              ),
            ],
          ),
          FutureBuilder<List<PortfolioModel>>(
              future: futurePortfolio,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.42,
                      child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(top: 30),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            // result
                            var data =
                                snapshot.data![index].chart!.result!.isNotEmpty
                                    ? snapshot.data![index].chart!.result![0]
                                    : null;
                            // open
                            List<num>? open = data?.indicators?.quote?[0].open
                                    ?.whereNotNull()
                                    .toList()
                                    .cast<num>() ??
                                [];
                            return InkWell(
                              onTap: () {
                                open.isNotEmpty
                                    ? modal(data)
                                    : Fluttertoast.showToast(
                                        msg:
                                            'no recent indicators for ${data!.meta!.symbol}',
                                        gravity: ToastGravity.BOTTOM);

                                //previously pushed data to new page,
                                // modal is a better alt for filtering to the api
                              },
                              child: snapshot.data![index].chart!.error != null
                                  ? const SizedBox(height: 0)
                                  : PortfolioBlock(
                                      name: data?.meta!.exchangeName! ?? '',
                                      chart: open,
                                      chartShow: true,
                                      title: data?.meta!.symbol! ?? '',
                                      previous:
                                          data?.meta!.chartPreviousClose ?? 0,
                                      regular:
                                          data?.meta!.regularMarketPrice ?? 0,
                                      currency: data?.meta!.currency ?? 'NA',
                                    ),
                            );
                          }),
                    );
                  } else if (snapshot.hasData) {
                    if (snapshot.data!.isEmpty) {
                      return const Text('No data',
                          style: TextStyle(fontSize: 20));
                    }
                  }
                }
                return const CircularProgressIndicator.adaptive(
                  backgroundColor: Colors.white,
                );
              }),
        ],
      ),
    );
  }

  filterValues(List val) {
    if (val.isNotEmpty) {
      return val.where((element) {
        return element[0] is String &&
            !element[0].contains(' ') &&
            element[0].length < 5 &&
            !element[0].contains('\$');
      }).toList();
    }
  }

  portfolioModal() {
    var newData = filterValues(_data);
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return Scaffold(
            backgroundColor: const Color(0xff24242a),
            bottomNavigationBar: Container(
              color: const Color(0xff272a34),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 20, 30, 30),
                child: Row(
                  children: [
                    Flexible(
                      child: TextButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            )),
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.only(top: 14, bottom: 14)),
                            backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xff353842))),
                        onPressed: () {
                          setState(() {
                            Navigator.pop(context);
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            SizedBox(width: 7),
                            Text(
                              'Close',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 25),
                    Flexible(
                      child: TextButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            )),
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.only(top: 14, bottom: 14)),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color(0xffd48154))),
                        onPressed: () {
                          setState(() {
                            _fetchPortfolio(list: selected);
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
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.only(top: 70, left: 25, right: 25),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: newData.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (selected.contains(newData[index][0])) {
                              selected.remove(newData[index][0]);
                            } else {
                              selected.add(newData[index][0]);
                            }
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: selected.contains(newData[index][0])
                                ? Colors.white
                                : const Color(0xff353842),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                          ),
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Center(
                                child: Container(
                                    height: 35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                        color: const Color(0xff353842),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.1),
                                            spreadRadius: 2,
                                            blurRadius: 7,
                                            offset: const Offset(0,
                                                5), // changes position of shadow
                                          ),
                                        ],
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(20))),
                                    child: Center(
                                      child: Text(
                                          newData[index][0].toString()[0],
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white)),
                                    )),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    newData[index][0].toString(),
                                    style: TextStyle(
                                        color:
                                            selected.contains(newData[index][0])
                                                ? const Color(0xff353842)
                                                : Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.6,
                                      child: Text(
                                        newData[index][1].toString(),
                                        style: TextStyle(
                                            color: selected
                                                    .contains(newData[index][0])
                                                ? const Color(0xff353842)
                                                : Colors.white),
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: false,
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  );
                },
              ),
            ),
          );
        });
      },
    );
  }

  modal(data) {
    List timeScales = ['5m', '15m', '1d', '1wk', ''];
    dynamic list = data.indicators!.quote![0].open!.map((e) => e);
    List<num> open = [
      for (var i in list)
        if (i != null) i
    ].cast<num>();
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return Scaffold(
              backgroundColor: const Color(0xff24242a),
              bottomNavigationBar: const StatBar(sell: true),
              body: Padding(
                padding: const EdgeInsets.only(top: 70, left: 25, right: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  width: 1, color: Color(0xff2b2e35)))),
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
                    const SizedBox(height: 30),
                    PortfolioBlock(
                      chartShow: false,
                      name: data.meta!.exchangeName!,
                      chart: const [],
                      title: data.meta!.symbol!,
                      previous: data.meta!.chartPreviousClose!,
                      regular: data.meta!.regularMarketPrice!,
                      currency: data.meta!.currency!,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        for (var i in timeScales)
                          TextButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          activeTime == i
                                              ? const Color(0xff353842)
                                              : Colors.transparent),
                                  fixedSize: MaterialStateProperty.all<Size>(
                                      const Size(10, 10))),
                              onPressed: () {
                                setState(() {
                                  _fetchPortfolio(number: i, list: selected);
                                  Navigator.of(context).pop();
                                  activeTime = i;
                                });
                              },
                              child: Text(i == '' ? 'Current' : i,
                                  style: const TextStyle(
                                      fontSize: 11, color: Colors.white))),
                      ],
                    ),
                    const SizedBox(height: 20),
                    StatChart(
                        positive: posOrNeg(data.meta!.regularMarketPrice!,
                            data.meta!.chartPreviousClose!),
                        data: open),
                    const SizedBox(height: 30),
                    _row(
                        'High Price',
                        data.indicators!.quote![0].high![0].toStringAsFixed(2),
                        data.meta!.currency!),
                    const SizedBox(height: 20),
                    _row(
                        'Low Price',
                        data.indicators!.quote![0].low![0].toStringAsFixed(2),
                        data.meta!.currency!),
                  ],
                ),
              ));
        });
      },
    );
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
}
