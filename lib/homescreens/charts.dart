import 'package:firedart/firestore/firestore.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';

class PieChartPage extends StatefulWidget {
  @override
  _PieChartPageState createState() => _PieChartPageState();
}


class _PieChartPageState extends State<PieChartPage> {
  int farmerCount = 0;
  int companyCount = 0;
  int dealerCount = 0;
  var  touchedIndex,total=0;


  @override
  void initState() {
    super.initState();
    getDocumentCount();
  }

  void getDocumentCount() async {
    var farmersSnapshot = await Firestore.instance.collection('farmers').get();
    farmerCount = farmersSnapshot.length;

    var companiesSnapshot = await Firestore.instance.collection('company').get();
    companyCount = companiesSnapshot.length;

    var dealersSnapshot = await Firestore.instance.collection('dealer').get();
    dealerCount = dealersSnapshot.length;

    setState(() {
      total=farmerCount+companyCount+dealerCount;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Container(
        height: size.height*0.37,
        width: size.width*0.25,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return PieChart(
              PieChartData(
                sections: [
                  PieChartSectionData(

                    value: farmerCount.toDouble(),
                    title: '${(farmerCount/total*100).toStringAsFixed(1)} %',
                    color: Colors.lightGreen.shade700,
                    radius: touchedIndex == 0 ? 90 : 70,
                    titleStyle: TextStyle(
                      fontSize: touchedIndex == 0 ? 18 : 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  PieChartSectionData(
                    value: companyCount.toDouble(),
                    title: '${(companyCount/total*100).toStringAsFixed(1)} %',
                    color: Colors.blue,
                    radius: touchedIndex == 1 ? 90 : 70,
                    titleStyle: TextStyle(
                      fontSize: touchedIndex == 1 ? 18 : 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  PieChartSectionData(
                    value: dealerCount.toDouble(),
                    title: '${(dealerCount/total*100).toStringAsFixed(1)} %',
                    color: Colors.orange,
                    radius: touchedIndex == 2 ? 90 : 70,
                    titleStyle: TextStyle(
                      fontSize: touchedIndex == 2 ? 18 : 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
                sectionsSpace: 0,
                centerSpaceRadius: 60,
                borderData: FlBorderData(
                  show: true,
                ),
                centerSpaceColor: Colors.white,
                pieTouchData: PieTouchData(
                  touchCallback: (FlTouchEvent event,  response) {
                    setState(() {
                      if (event is PointerUpEvent) {
                        touchedIndex = -1;
                      } else if (response!.touchedSection != null) {
                        touchedIndex = response.touchedSection!.touchedSectionIndex;
                      }
                    });
                  },
                ),



              ),
            );
          }
        ),

    );
  }
}




class Color_displayer_chart extends StatelessWidget{
  var color,name;
  Color_displayer_chart({required this.name,required this.color});
  @override
  Widget build(BuildContext context) {
   return Container(
     child: Row(
       children: [
       Container(
         height: 20,
         width: 30,
         decoration: BoxDecoration(
         color: color,
         shape: BoxShape.rectangle
       ),),
         Text('   ${name}')
     ],),
   );
  }

}






























class LineChartWidget extends StatelessWidget {
  final List<FlSpot> spots;

  const LineChartWidget({Key? key, required this.spots}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Container(
      height: 300,
      width: size.width*0.42,
      child: LineChart(
        LineChartData(
          lineTouchData: LineTouchData(enabled: false),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: true,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: Colors.grey,
                strokeWidth: 1,
              );
            },
            getDrawingVerticalLine: (value) {
              return FlLine(
                color: Colors.grey,
                strokeWidth: 1,
              );
            },
          ),
          borderData: FlBorderData(
            show: true,
            border: Border.all(
              color: Colors.grey,
              width: 1,
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              color: Colors.lightGreen,
              barWidth: 3,
              dotData: FlDotData(show: false),
            ),
          ],
          minX: 3,
          maxX: spots.length.toDouble() - 1,
          minY: 3,
          maxY: _calculateMaxY(spots),
        ),
      ),
    );
  }

  double _calculateMaxY(List<FlSpot> spots) {
    double maxY = 0;

    for (var spot in spots) {
      if (spot.y > maxY) {
        maxY = spot.y;
      }
    }

    return maxY + 50;
  }
}






































class DataPoint {
  final DateTime date;
  late final double value;

  DataPoint(this.date, this.value);
}


class MyChart extends StatefulWidget {
  @override
  _MyChartState createState() => _MyChartState();
}

class _MyChartState extends State<MyChart> {
  List<DataPoint> _combinedData = [];
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final farmersData = await _getFarmersData();
    final companyData = await _getCompanyData();
    final dealerData = await _getDealerData();

    final combinedData = <DataPoint>[];

    for (final dataPoint in farmersData) {
      combinedData.add(DataPoint(dataPoint.date, dataPoint.value));
    }

    for (final dataPoint in companyData) {
      final index = combinedData.indexWhere((dp) => dp.date == dataPoint.date);
      if (index == -1) {
        combinedData.add(DataPoint(dataPoint.date, dataPoint.value));
      } else {
        combinedData[index].value += dataPoint.value;
      }
    }

    for (final dataPoint in dealerData) {
      final index = combinedData.indexWhere((dp) => dp.date == dataPoint.date);
      if (index == -1) {
        combinedData.add(DataPoint(dataPoint.date, dataPoint.value));
      } else {
        combinedData[index].value += dataPoint.value;
      }
    }

    combinedData.sort((a, b) => a.date.compareTo(b.date));
    setState(() {
      _combinedData = combinedData;
    });
  }

  Future<List<DataPoint>> _getFarmersData() async {
    final farmersSnapshot =
    await Firestore.instance.collection('farmers').get();
    final farmersData = farmersSnapshot.map((doc) {
      final date = DateTime.fromMillisecondsSinceEpoch(
          doc['date'].millisecondsSinceEpoch);
      final value = doc['value'] as double;
      return DataPoint(date, value);
    }).toList();
    return farmersData;
  }

  Future<List<DataPoint>> _getCompanyData() async {
    final companySnapshot =
    await Firestore.instance.collection('company').get();

    final companyData = companySnapshot.map((doc) {
      final date = DateTime.fromMillisecondsSinceEpoch(
          doc['date'].millisecondsSinceEpoch);
      final value = doc['value'] as double;

      return DataPoint(date, value);
    }).toList();

    return companyData;
  }

  Future<List<DataPoint>> _getDealerData() async {
    final dealerSnapshot =
    await Firestore.instance.collection('dealer').get();

    final dealerData = dealerSnapshot.map((doc) {
      final date = DateTime.fromMillisecondsSinceEpoch(
          doc['date'].millisecondsSinceEpoch);
      final value = doc['value'] as double;

      return DataPoint(date, value);
    }).toList();

    return dealerData;
  }


  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 300,
        width: 300,
        child: SizedBox(
          height: 400,
          child: _combinedData.isEmpty
              ? CircularProgressIndicator()
              : Container(
            height: 300,
            width: 300,
                child: LineChart(
            LineChartData(
                lineBarsData: [
                  LineChartBarData(
                    spots: _combinedData
                        .map((dataPoint) => FlSpot(
                      dataPoint.date.millisecondsSinceEpoch.toDouble(),
                      dataPoint.value,
                    ))
                        .toList(),
                    isCurved: true,
                    color: Colors.blue,
                    barWidth: 4,
                    dotData: FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      color: Colors.red,
                    ),
                  ),
                ],
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                   sideTitles:SideTitles(
                     showTitles: true,

                   ),
                  ),

                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(color: Colors.black26, width: 1),
                ),
                minX: _combinedData.first.date.millisecondsSinceEpoch.toDouble(),
                maxX: _combinedData.last.date.millisecondsSinceEpoch.toDouble(),
                minY: 0,
                maxY: _combinedData.map((dp) => dp.value).reduce((a, b) => a + b),
            ),
          ),
              ),
        ),

    );
  }
}

















