import 'package:currencyapp/Models/Home_Model.dart';
import 'package:currencyapp/View%20Model/Network/coin_api.dart';
import 'package:currencyapp/View%20Model/Network/dio_exceptions.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class HomeProvider extends ChangeNotifier{
  List<Home_Model> coinlist=[];

  getallcoin()async{
    try{
    CoinApi().getdata().then((value) {
      coinlist=value;
      notifyListeners();
    });}
      on DioError catch(e){
        String error = DioExceptions.fromDioError(e).toString();
        print(error);
        Get.dialog(
          AlertDialog(
            title: Text("Error"),
            content: Text(error),
            actions: [
              TextButton(onPressed: () {
                getallcoin();
                Get.back();
              },child: Text("Ok"),)
            ],
          )
        );
      }
  }

}