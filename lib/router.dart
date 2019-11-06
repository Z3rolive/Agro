import 'package:agro/main.dart';
import 'package:agro/mainMenu.dart';
import 'package:agro/order/home.dart';
import 'package:agro/pages/aboutpage.dart';
import 'package:agro/pages/librarypage.dart';
import 'package:agro/pages/newspage.dart';
import 'package:agro/pages/querypage.dart';
import 'package:agro/router_constants.dart';
import 'package:agro/sharedloginregister.dart';
import 'package:flutter/material.dart';
import 'package:agro/pages/error_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args=settings.arguments;
    switch (settings.name) {
      case SplashRoute:
        return MaterialPageRoute(builder: (context) => Splash());
      case QueryRoute:
        return MaterialPageRoute(builder: (context) => AddData(value: args,));
      case LoginRoute:
        return MaterialPageRoute(builder: (context) => Login());
      case OrderRoute:
        return MaterialPageRoute(builder: (context) => HomePage());
      case AboutRoute:
        return MaterialPageRoute(builder: (context) => AboutPage());
      case NewsRoute:
        return MaterialPageRoute(builder: (context) => NewsPage());
      case LibraryRoute:
      return MaterialPageRoute(builder: (context) => LibraryPage());
      default:
        return MaterialPageRoute(builder: (context) => Error());
    }
  }
}
