import 'package:currencyapp/View%20Model/Provider/Details_provider.dart';
import 'package:currencyapp/View%20Model/Provider/Home_Provider.dart';
import 'package:currencyapp/View/Screens/Details_Screen.dart';
import 'package:currencyapp/View/Screens/Profile%20Screen.dart';
import 'package:currencyapp/View/Screens/Search_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import '../../core/themes.dart';

class Coins_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<HomeProvider>(context);
    return Consumer<HomeProvider>(builder: (context, value, child) {
      return value.coinlist.length<0?CircularProgressIndicator():Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text(
              "Crypto Currency",
            ),
            actions: [
              PopupMenuButton<int>(
                onSelected: (value) {
                  switch(value){
                    case 0 :
                      Get.to(Profile_Screen());
                      break;
                    case 1 :
                      Get.to(SearchScreen());
                  }
                },
                itemBuilder:(context) => [
                  PopupMenuItem(child: Row(children: [
                    Icon(Icons.account_circle_outlined,),
                    SizedBox(width: 5,),
                    Text("Profile")
                  ],),value: 0,),
                  PopupMenuItem(child: Row(children: [
                    Icon(Icons.search,),
                    SizedBox(width: 5,),
                    Text("Search")
                  ],),value: 1,),
                ],
              )


            ],
          ),
          body: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: prov.coinlist.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(15),
                child: GestureDetector(
                  onTap: () {
                    Provider.of<DetailsProvider>(context, listen: false)
                        .getallcoin(prov.coinlist[index].id);
                    Get.to(Details_Screen(id: prov.coinlist[index].id));
                  },
                  child: Container(
                    width: double.infinity,
                    height: 110,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Themes.isDarkMode(context)?HexColor('293241'):HexColor('#DBD7D8')
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Text(
                              Provider.of<HomeProvider>(context)
                                  .coinlist[index]
                                  .rank
                                  .toString(),
                            ),
                          ),
                          Image.network(
                            prov.coinlist[index].image,
                            width: 50,
                            height: 50,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    prov.coinlist[index].name,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    prov.coinlist[index].symbol,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                    '${prov.coinlist[index].current_price}',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    )
                                ),
                                Text(
                                    '${prov.coinlist[index].pricechange}',
                                    maxLines: 1,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: prov.coinlist[index].pricechange>0?Colors.green:Colors.red)),
                                Text(
                                    '${prov.coinlist[index].pricechange_percentage}%',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: prov.coinlist[index].pricechange_percentage>0?Colors.green:Colors.red))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ));
    },);
  }
}
