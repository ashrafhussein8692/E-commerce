import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';

import 'modules/shop_layout/layout/shop_layout.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.network(
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS0OpsCLto4sXJMMRg3o_x4Gfe3lwYQ5lwx1A&usqp=CAU',
        fit: BoxFit.cover,
        height: 300,
        width: 300
      ),
      title: const Text(
        "Salla",
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.white,
      showLoader: true,
      loadingText: const Text("Loading..."),
      navigator: ShopLayOut(),
      durationInSeconds: 3,
    );
  }
}
