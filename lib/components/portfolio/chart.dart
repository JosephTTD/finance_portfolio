import 'package:flutter/material.dart';
//import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class StatChart extends StatefulWidget {
  const StatChart({Key? key, required this.data, this.positive = false})
      : super(key: key);

  //final String status;
  final List<num>? data;
  final bool? positive;

  @override
  State<StatChart> createState() => _StatChartState();
}

class _StatChartState extends State<StatChart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      height: MediaQuery.of(context).size.height * 0.37,
      child: SfSparkLineChart(
          color: widget.positive == true
              ? const Color(0xff406e56)
              : const Color(0xff9e3f4f),
          axisLineWidth: 1,
          axisLineColor: const Color(0xff2c2d34),
          trackball: const SparkChartTrackball(
              activationMode: SparkChartActivationMode.tap),
          marker: const SparkChartMarker(
              displayMode: SparkChartMarkerDisplayMode.none),
          data: widget.data ?? <double>[0, 1],
          //widget.data,
          ),
    );
  }
}
