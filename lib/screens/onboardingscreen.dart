import 'package:agro/routes/router_constants.dart';
import 'package:agro/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:agro/constants/constant.dart';
import 'package:fancy_on_boarding/fancy_on_boarding.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final pageList = [
    PageModel(
        color: const Color(0xFF678FB4),
        heroAssetPath: 'assets/Header.png',
        title: Text(
          'Ask queries',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Colors.white,
            fontSize: 34.0,
          ),
        ),
        body: Text(
          'We have experts available to support and suggest you on your issue.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
        ),
        iconAssetPath: 'assets/key.png'),
    PageModel(
        color: const Color(0xFF65B0B4),
        heroAssetPath: 'assets/Header.png',
        title: Text(
          'View Products',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Colors.white,
            fontSize: 34.0,
          ),
        ),
        body: Text(
            'Products are available on marketplace which you can order and buy at your convenience',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            )),
        iconAssetPath: 'assets/wallet.png'),
    PageModel(
      color: const Color(0xFF9B90BC),
      heroAssetPath: 'assets/Header.png',
      title: Text('Documentations',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Colors.white,
            fontSize: 34.0,
          )),
      body: Text('Documents are available for particular farms and their methods of farming.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          )),
      iconAssetPath: 'assets/shopping_cart.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FancyOnBoarding(
        doneButtonText: "Done",
        skipButtonText: "Skip",
        pageList: pageList,
        onDoneButtonPressed: () =>
            Navigator.of(context).pushReplacementNamed('/login'),
        onSkipButtonPressed: () =>
            Navigator.of(context).pushReplacementNamed('/login'),
      ),
    );
  }
}
