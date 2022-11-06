import 'package:currencyapp/View/Screens/Auth_Screens/Login_Screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../View Model/Provider/Control_Provider.dart';
import '../Coins_Screen.dart';

class StillLogin extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Consumer<ControlProvider>(builder: (context, value, child) {
      return value.id==null ? LoginScreen():Coins_Screen();
    },);
  }
}
