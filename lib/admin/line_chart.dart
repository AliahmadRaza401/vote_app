import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class VoteChart extends StatefulWidget {
  VoteChart({required this.docs});

  late final List<QueryDocumentSnapshot<Object?>> docs;
  @override
  State<StatefulWidget> createState() => VoteChartState();
}

class VoteChartState extends State<VoteChart> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<_ChartData> databarFB = widget.docs.map((doc) {
      double totalVote = double.parse(doc['totalVote'].toString());
      String voteName = doc['voteName'].toString();
      int value2 = 0;

      return _ChartData(voteName, totalVote, value2);
    }).toList();

    return Container(
      margin: EdgeInsets.only(bottom: 20, top: 20),
      // width: 344,
      // height: 308,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 0.50,
            strokeAlign: BorderSide.strokeAlignCenter,
            color: Colors.black.withOpacity(0.1599999964237213),
          ),
          borderRadius: BorderRadius.circular(9),
        ),
      ),

      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Vote Statistics",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              primaryYAxis: NumericAxis(minimum: 0, maximum: 100, interval: 15),
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <ChartSeries<_ChartData, String>>[
                ColumnSeries<_ChartData, String>(
                    dataSource: databarFB,
                    xValueMapper: (_ChartData data, _) => data.x.toString(),
                    yValueMapper: (_ChartData data, _) => data.y,
                    color: const Color(0xFF50A6E2))
              ]),
        ],
      ),
    );
  }
}

class _ChartData {
  _ChartData(this.x, this.y, this.z);

  // final DateTime x;
  final String x;
  final double y;
  final int z;
}

  // List<_ChartData> dataBar = [
  //   _ChartData("14\nSep", 70, 2),
  //   _ChartData("15\nSep", 60, 10),
  //   _ChartData("16\nSep", 80, 6),
  //   _ChartData("17\nSep", 30, 5),
  //   _ChartData("18\nSep", 12, 10),
  //   _ChartData("19\nSep", 15, 30),
  //   _ChartData("20\nSep", 30, 40),
  //   _ChartData("21\nSep", 6.4, 2),
  //   _ChartData("22\nSep", 14, 4)
  // ];