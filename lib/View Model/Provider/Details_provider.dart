import 'package:flutter/material.dart';

import '../../Models/Details_models.dart';
import '../Network/coin_api.dart';

class DetailsProvider extends ChangeNotifier {
  Details_Model coinlist = Details_Model(
      rank: 0,
      name: "",
      symbol: "",
      current_price: 0,
      image: "",
      percentchange_24h: 0,
      percentchange_7d: 0,
      per_ch_14: 0,
      per_ch_30: 0,
      per_ch_60: 0,
      per_ch_200: 0,
      per_ch_1y: 0,
      description: "");

  getallcoin(String id) async {
    CoinApi().getdetaildata(id).then((value) {
      coinlist = value;
      notifyListeners();
    });
  }
}
