import 'package:currencyapp/View%20Model/Provider/Details_provider.dart';
import 'package:currencyapp/core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';


class Details_Screen extends StatelessWidget {
final String id;

Details_Screen({required this.id});

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<DetailsProvider>(context);
    var data = [
      ChartData('1y', prov.coinlist.per_ch_1y),
      ChartData('6M', prov.coinlist.per_ch_200),
      ChartData('2M', prov.coinlist.per_ch_60),
      ChartData('1M', prov.coinlist.per_ch_30),
      ChartData('2W', prov.coinlist.per_ch_14),
      ChartData('1W', prov.coinlist.percentchange_7d),
      ChartData('24H', prov.coinlist.percentchange_24h),
    ];
    var theme = Themes.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        title: Card(
            elevation: 10,
            margin: EdgeInsets.all(10),
            shape: CircleBorder(),
            child: Image.network(prov.coinlist.image,fit: BoxFit.cover,filterQuality: FilterQuality.high,)
        ),
        centerTitle: true,
        toolbarHeight:150,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        primary: true,
        child: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(flex: 1,child: Text(prov.coinlist.name,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
                  SizedBox(width: 170,),
                  Text("Rank",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                  SizedBox(width: 5,),
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.green),
                    child: Center(child: Text('${prov.coinlist.rank}',style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold,fontSize: 15 ),)),
                  )
                ],
              ),
              Text(prov.coinlist.symbol,style: TextStyle(fontSize: 18,color: Colors.grey),),
              SizedBox(height: 5,),
              Text('Price',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
              Text('${prov.coinlist.current_price}',style: TextStyle(fontSize: 20,color: prov.coinlist.percentchange_7d>0?Colors.green:Colors.red),),
              Text('${prov.coinlist.percentchange_24h}%',style: TextStyle(fontSize: 20,color: prov.coinlist.percentchange_24h>0?Colors.green:Colors.red),),
              SizedBox(height: 10,),
              Container(
                 decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: HexColor('293241'),),
                child: SfCartesianChart(
                  margin: EdgeInsets.all(20),
                    primaryXAxis:CategoryAxis(isVisible: true,
                      majorGridLines: MajorGridLines(width: 1),
                      axisLine: AxisLine(width: 5,),
                      labelStyle: TextStyle( fontSize: 20,color: Colors.white),
                      majorTickLines: MajorTickLines(size:0),
                    ) ,
                    primaryYAxis: CategoryAxis(isVisible: false,),
                    series: <ChartSeries<ChartData,String>>[
                      LineSeries(dataSource: data,
                          dataLabelSettings: DataLabelSettings(isVisible: true,color: theme?Colors.white:Colors.black),
                          color: Colors.green,
                          xValueMapper: (ChartData sales,_)=>sales.x.toString(),
                          yValueMapper: (ChartData sales,_)=>sales.y
                      ),
                    ]),
              ),
              SizedBox(height: 15,),
              Text("Description",
                style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              Html(
                data: prov.coinlist.description,
                style:{
                  "body":Style(
                    color: theme?Colors.white:Colors.black,
                    fontSize: FontSize(15),
                    fontStyle: FontStyle.italic,
                    display: Display.block,
                  )
                }

              ),
            ],
          ),
        ),
          ),
      ),
    );
  }
}
class ChartData{
  ChartData(this.x,this.y);

  String x;
  double y;
}
