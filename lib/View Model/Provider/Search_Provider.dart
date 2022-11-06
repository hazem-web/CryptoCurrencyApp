import 'package:currencyapp/View%20Model/Network/coin_api.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../Models/Search_Model.dart';

class SearchProvider extends ChangeNotifier{
List<Search_Model> searchlist = [];

getsearch(String name){
  CoinApi().getsearchdata(name).then((value) {
    searchlist=value;
    print(searchlist[0].name);
    notifyListeners();
  }).catchError((error){
    print(error);
  });
}

}