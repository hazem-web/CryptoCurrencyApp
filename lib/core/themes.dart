import 'package:flutter/material.dart';

class Themes {

  static ThemeData lightTheme = ThemeData(
    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(color: Colors.black, fontSize: 20,
          fontWeight: FontWeight.bold
      ),
      backgroundColor:Colors.transparent ,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black,),
    ),
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    textTheme: TextTheme(
      bodyText2: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      )
    )

  );


  static ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.grey,
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(
       backgroundColor: Colors.transparent,
        titleTextStyle: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),
        elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
    ),
    scaffoldBackgroundColor: Colors.black,
      textTheme: TextTheme(
          bodyText2: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          )
      )


  );


  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
    }



  }