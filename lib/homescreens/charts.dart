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
    QuerySnapshot farmersSnapshot = await FirebaseFirestore.instance.collection('farmers').get();
    farmerCount = farmersSnapshot.size;

    QuerySnapshot companiesSnapshot = await FirebaseFirestore.instance.collection('companies').get();
    companyCount = companiesSnapshot.size;

    QuerySnapshot dealersSnapshot = await FirebaseFirestore.instance.collection('dealers').get();
    dealerCount = dealersSnapshot.size;

    setState(() {
      total=farmerCount+companyCount+dealerCount;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Container(
      height: size.height*0.32,
      width: size.width*0.32,
      child: PieChart(
        PieChartData(
          sections: [
            PieChartSectionData(
              value: farmerCount.toDouble(),
              title: 'Farmers',
              color: Colors.blue,
              radius: touchedIndex == 0 ? 90 : 70,
              titleStyle: TextStyle(
                fontSize: touchedIndex == 0 ? 18 : 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            PieChartSectionData(
              value: companyCount.toDouble(),
              title: 'Companies',
              color: Colors.green,
              radius: touchedIndex == 1 ? 90 : 70,
              titleStyle: TextStyle(
                fontSize: touchedIndex == 1 ? 18 : 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            PieChartSectionData(
              value: dealerCount.toDouble(),
              title: 'Dealer',
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
            show: false,
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
      ),
    );
  }
}
