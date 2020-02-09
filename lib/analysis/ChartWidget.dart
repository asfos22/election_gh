import 'package:flutter/material.dart';
import 'package:multi_charts/multi_charts.dart';

class ChartWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Radar Chart Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Radar Chart Example"),
        ),
        body: Column(children: [
          Container(
margin: EdgeInsets.only(top: 64.0),
            //Radar Chart
            child:
          //Pie Chart
          PieChart(
            values: [15, 10, 30, 25, 20],
            labels: ["NPP", "CPP", "NDC", "PNDC", "NDP"],
            sliceFillColors: [
              Colors.blueAccent,
              Colors.greenAccent,
              Colors.pink,
              Colors.orange,
              Colors.red,
            ],
            animationDuration: Duration(milliseconds: 1500),
            legendPosition: LegendPosition.Right,
          ),
          )
        ]),
      ),
    );
  }
}