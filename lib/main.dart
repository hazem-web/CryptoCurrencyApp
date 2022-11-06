import 'package:currencyapp/View%20Model/Provider/Control_Provider.dart';
import 'package:currencyapp/View%20Model/Provider/Details_provider.dart';
import 'package:currencyapp/View%20Model/Provider/Photo%20Provider.dart';
import 'package:currencyapp/View%20Model/Provider/Search_Provider.dart';
import 'package:currencyapp/View%20Model/Provider/Theme%20provider.dart';
import 'package:currencyapp/View%20Model/Provider/auth_provider.dart';
import 'package:currencyapp/View/Screens/Auth_Screens/Still_Login_Screen.dart';
import 'package:currencyapp/core/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';

import 'View Model/Provider/Home_Provider.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => HomeProvider()..getallcoin()),
    ChangeNotifierProvider(create: (context) => Auth_Provider(),),
    ChangeNotifierProvider(create: (context) => Theme_Provider()..getThemeModeFromSharedPref()),
    ChangeNotifierProvider(create: (context) => ControlProvider(),),
    ChangeNotifierProvider(create: (context) => DetailsProvider(),),
    ChangeNotifierProvider(create: (context) => SearchProvider(),),
    ChangeNotifierProvider(create: (context) => PhotoProvider(),),
  ],child:MyApp() ,));
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Provider.of<Theme_Provider>(context,listen: false).getThemeModeFromSharedPref();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Themes.lightTheme,
      darkTheme: Themes.darkTheme,
      themeMode: Provider.of<Theme_Provider>(context).themeMode,
      home:StillLogin()
    );
  }
}
