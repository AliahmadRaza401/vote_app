// ignore_for_file: must_be_immutable

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// class _LineChart extends StatelessWidget {
// final List<int> voteCounts;
// final List<DateTime> votingDates;

// _LineChart({required this.voteCounts, required this.votingDates});

// double getMaxVoteCount(List<int> voteCounts) {
//   if (voteCounts.isEmpty) return 0;
//   return voteCounts.reduce((max, count) => count > max ? count : max).toDouble();
// }

// List<FlSpot> getChartData() {
//   List<FlSpot> chartData = [];
//   for (int i = 0; i < voteCounts.length; i++) {
//     chartData.add(FlSpot(i.toDouble(), voteCounts[i].toDouble()));
//   }
//   return chartData;
// }

//   @override
//   Widget build(BuildContext context) {
//     return LineChart(
//       LineChartData(
//         lineBarsData: [
//           LineChartBarData(
//             isCurved: true,
//             colors: [ChartColors.primary],
//             dotData: FlDotData(show: false),
//             belowBarData: BarAreaData(show: false),
//             spots: getChartData(),
//           ),
//         ],
//         titlesData: FlTitlesData(
//           bottomTitles: AxisTitles(
//             showTitles: true,
//             interval: 1, // Customize as needed
//           ),
//           leftTitles: AxisTitles(
//             showTitles: true,
//             interval: 10, // Customize as needed
//           ),
//         ),
//         borderData: FlBorderData(
//           show: true,
//           border: const Border(
//             bottom: BorderSide(color: Colors.black.withOpacity(0.2), width: 3),
//             left: BorderSide(color: Colors.black.withOpacity(0.2), width: 3),
//           ),
//         ),
//         gridData: FlGridData(
//           show: false,
//         ),
// minX: 0,
// maxX: voteCounts.length.toDouble() - 1,
// minY: 0,
// maxY: getMaxVoteCount(voteCounts),
//       ),
//     );
//   }
// }

class LineChartSample1 extends StatefulWidget {
  LineChartSample1({required this.voteCounts, required this.votingDates});

  late final List<int> voteCounts;
  late final List<DateTime> votingDates;
  @override
  State<StatefulWidget> createState() => LineChartSample1State();
}

class LineChartSample1State extends State<LineChartSample1> {
  late bool isShowingMainData;

  @override
  void initState() {
    super.initState();
    isShowingMainData = true;
  }

  @override
  Widget build(BuildContext context) {
    print('voteCounts: ${widget.voteCounts}');
    print('voteCounts: ${widget.votingDates}');

    return AspectRatio(
      aspectRatio: 1.6,
      child: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 40,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: 16, left: 6),
                  child: _LineChart(
                    isShowingMainData: isShowingMainData,
                    voteCounts: widget.voteCounts,
                    votingDates: widget.votingDates,
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            right: 0,
            child: IconButton(
              icon: Icon(
                Icons.refresh,
                color: Colors.red.withOpacity(isShowingMainData ? 1.0 : 0.5),
              ),
              onPressed: () {
                setState(() {
                  isShowingMainData = !isShowingMainData;
                });
              },
            ),
          )
        ],
      ),
    );
  }
}

class _LineChart extends StatelessWidget {
  _LineChart(
      {required this.isShowingMainData,
      required this.voteCounts,
      required this.votingDates});
  late final List<int> voteCounts;
  late final List<DateTime> votingDates;

  final bool isShowingMainData;

  double getMaxVoteCount(List<int> voteCounts) {
    if (voteCounts.isEmpty) return 0;
    return voteCounts
        .reduce((max, count) => count > max ? count : max)
        .toDouble();
  }

  List<FlSpot> getChartData() {
    List<FlSpot> chartData = [];
    for (int i = 0; i < voteCounts.length; i++) {
      chartData.add(FlSpot(i.toDouble(), voteCounts[i].toDouble()));
    }
    return chartData;
  }

  @override
  Widget build(BuildContext context) {
    return LineChart(
      isShowingMainData ? sampleData1 : sampleData2,
    );
  }

  LineChartData get sampleData1 => LineChartData(
        lineTouchData: lineTouchData1,
        gridData: gridData,
        titlesData: titlesData1,
        borderData: borderData,
        lineBarsData: lineBarsData1,
        minX: 0,
        maxX: voteCounts.length.toDouble() - 1,
        minY: 0,
        maxY: getMaxVoteCount(voteCounts),
      );

  LineChartData get sampleData2 => LineChartData(
        lineTouchData: lineTouchData2,
        gridData: gridData,
        titlesData: titlesData2,
        borderData: borderData,
        lineBarsData: lineBarsData2,
        minX: 0,
        maxX: voteCounts.length.toDouble() - 1,
        minY: 0,
        maxY: getMaxVoteCount(voteCounts),
      );

  LineTouchData get lineTouchData1 => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
      );

  FlTitlesData get titlesData1 => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  List<LineChartBarData> get lineBarsData1 => [
        lineChartBarData1_2,
        lineChartBarData1_3,
      ];

  LineTouchData get lineTouchData2 => LineTouchData(
        enabled: false,
      );

  FlTitlesData get titlesData2 => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  List<LineChartBarData> get lineBarsData2 => [
        lineChartBarData2_2,
        lineChartBarData2_3,
      ];

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'OMB';
        break;
      case 10:
        text = '10MB';
        break;
      case 20:
        text = '20MB';
        break;
      case 30:
        text = '30MB';
        break;
      case 40:
        text = '40MB';

        break;
      default:
        return SizedBox();
    }

    return Text(text,
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
          color: Color(0xff7c808b),
          fontFamily: 'popinsregular',
        ),
        textAlign: TextAlign.center);
  }

  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        interval: 2,
        reservedSize: 40,
      );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    TextStyle style = TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
      color: Color(0xff7c808b),
      fontFamily: 'popinsregular',
    );
    Widget text;
    switch (value.toInt()) {
      case 2:
        text = Text('10', style: style);
        break;
      case 6:
        text = Text('20', style: style);
        break;
      case 12:
        text = Text('15', style: style);
        break;
      case 18:
        text = Text('20', style: style);
        break;
      case 24:
        text = Text('25', style: style);
        break;
      case 32:
        text = Text('30', style: style);
        break;
      default:
        text = Text('');
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: text,
    );
  }

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );

  FlGridData get gridData => FlGridData(show: false);

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: Border(
          bottom: BorderSide(color: Colors.black.withOpacity(0.2), width: 3),
          left: BorderSide(color: Colors.black.withOpacity(0.2), width: 3),
        ),
      );

  LineChartBarData get lineChartBarData1_2 => LineChartBarData(
        isCurved: true,
        color: Colors.black,
        barWidth: 3,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(
          show: false,
          color: Colors.black.withOpacity(0),
        ),
        spots: getChartData(),
      );

  LineChartBarData get lineChartBarData1_3 => LineChartBarData(
        isCurved: true,
        color: Colors.blue,
        barWidth: 3,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: getChartData(),
      );

  LineChartBarData get lineChartBarData2_2 => LineChartBarData(
        isCurved: true,
        color: Colors.green.withOpacity(0.5),
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(
          show: true,
          color: Colors.black.withOpacity(0.2),
        ),
        spots: getChartData(),
      );

  LineChartBarData get lineChartBarData2_3 => LineChartBarData(
        isCurved: true,
        curveSmoothness: 0,
        color: Colors.blue.withOpacity(0.5),
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(show: true),
        belowBarData: BarAreaData(show: false),
        spots: getChartData(),
      );
}

class ChartColors {
  static const Color primary = contentColorCyan;
  static const Color menuBackground = Color(0xFFFF683B);
  static const Color itemsBackground = Color(0xFF1B2339);
  static const Color pageBackground = Color(0xFFFF683B);
  static const Color mainTextColor1 = Colors.white;
  static const Color mainTextColor2 = Colors.white70;
  static const Color mainTextColor3 = Color(0xFFFF683B);
  static const Color mainGridLineColor = Color(0xFFFF683B);
  static const Color borderColor = Color(0xFFFF683B);
  static const Color gridLinesColor = Color(0x11FFFFFF);

  static const Color contentColorBlack = Color(0xFFFF683B);
  static const Color contentColorWhite = Colors.white;
  static const Color contentColorBlue = Color(0xFF2196F3);
  static const Color contentColorYellow = Color(0xFFFFC300);
  static const Color contentColorOrange = Color(0xFFFF683B);
  static const Color contentColorGreen = Color(0xFF3BFF49);
  static const Color contentColorPurple = Color(0xFF6E1BFF);
  static const Color contentColorPink = Color(0xFFFF3AF2);
  static const Color contentColorRed = Color(0xFFE80054);
  static const Color contentColorCyan = Colors.black;
}
