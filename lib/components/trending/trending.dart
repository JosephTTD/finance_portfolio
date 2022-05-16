import 'package:finance_portfolio/api/api.dart';
import 'package:finance_portfolio/components/text/title.dart';
import 'package:finance_portfolio/components/trending/slide.dart';
import 'package:finance_portfolio/models/trend.dart';
import 'package:flutter/material.dart';

class Trending extends StatefulWidget {
  const Trending({Key? key}) : super(key: key);

  @override
  State<Trending> createState() => _TrendingState();
}

class _TrendingState extends State<Trending> {
  late Future<Trend> futureTrend;

  @override
  void initState() {
    futureTrend = fetchTrend();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 18, bottom: 20),
          child: BlockTitle(title: 'Trending'),
        ),
        //TrendingSlide()
        FutureBuilder<Trend>(
          future: futureTrend,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SizedBox(
                height: 80,
                child: ListView.builder(
                    itemCount:
                        snapshot.data!.finance!.result![0].quotes!.length,
                    padding: const EdgeInsets.only(left: 20),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return TrendingSlide(
                          quote: snapshot.data!.finance!.result![0]
                              .quotes![index].symbol!);
                    }),
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator.adaptive(
              backgroundColor: Colors.white,
            );
          },
        ),
      ],
    );
  }
}
