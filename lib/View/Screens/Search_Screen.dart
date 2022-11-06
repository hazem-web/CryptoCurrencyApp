
import 'package:currencyapp/View%20Model/Provider/Search_Provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';

import '../../View Model/Provider/Details_provider.dart';
import '../../core/themes.dart';
import 'Details_Screen.dart';

class SearchScreen extends StatelessWidget {

var text = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<SearchProvider>(builder: (context, value, child) {
      return value.searchlist.length<0?CircularProgressIndicator():Scaffold(
        backgroundColor: Themes.isDarkMode(context)?Colors.black:Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          toolbarHeight: 100,
          title: TextFormField(
            controller: text,
            onChanged: (index) {
              value.getsearch(index);
            },

            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search_rounded,color: Colors.green,),
              suffixIcon: IconButton(icon: Icon(Icons.clear,color: Colors.red,),onPressed: () {
                text.clear();
              },),
              hintText: "Search for a coin",
              hintStyle: TextStyle(color: Colors.grey),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey,style: BorderStyle.solid)
              ),
              border:  OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey,style: BorderStyle.solid)
              ),
            ),
          ),
        ),
        body:value.searchlist.length==0?Center(child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/loupe-search-svgrepo-com.svg',width: 150,height: 150,),
            Text("Search for a coin",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),)
          ],
        )):ListView.separated(
          separatorBuilder: (context, index) {
            return Container(
              width: double.infinity,
              height: 1.5,
              color: Colors.black,
            );
          },
          itemCount: value.searchlist.length,
          itemBuilder:(context, index) {
            return Padding(
              padding: const EdgeInsets.all(15),
              child: GestureDetector(
                onTap: () {

                  Provider.of<DetailsProvider>(context, listen: false)
                      .getallcoin(value.searchlist[index].id);
                  Get.to(Details_Screen(id: value.searchlist[index].id));
                },
                child: Container(
                  width: double.infinity,
                  height: 110,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: HexColor('293241')),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Image.network(
                          value.searchlist[index].image,
                          width: 50,
                          height: 50,
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  value.searchlist[index].name,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Text(
                                  value.searchlist[index].symbol,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                "Rank",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                            Text(
                              value.searchlist[index].rank.toString(),
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                              ),
                            )],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },

        ),
      );
    },);
  }
}

