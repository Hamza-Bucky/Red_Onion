import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';
import 'package:lottie/lottie.dart';
import 'package:tunnel/helpers/ad_helper.dart';
import 'package:tunnel/main.dart';
import 'package:tunnel/screens/home_screen.dart';

class splashscreen extends StatefulWidget {
  const splashscreen({super.key});

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  //ADDING DELAY IN SPLASH SCREEN
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      //TURNING FULL SCREEN MODE OF
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

      AdHelper.precacheInterstitialAd();
      AdHelper.precacheNativeAd();
      //NAVIGATING TO THE HOME PAGE AFTER SPLASH SCREEN
      Get.off(() => HomeScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    mediaq = MediaQuery.of(context).size;
    //SETTING UP SPLASH SCREEN
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Color(0xffffa28d),
            Color(0xfffc878c),
            Color(0xfffc7c8c),
            Color(0xfffc4584)
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          transform: GradientRotation(0.1),
        )),
        child: Stack(
          children: [
            Positioned(
                left: mediaq.width * 0.31,
                top: mediaq.height * 0.4,
                width: mediaq.width * 0.41,
                child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.white,
                    child: Image.asset(
                      'assets/images/red-onion1.png',
                    ))),
            Positioned(
              bottom: mediaq.height * 0.2,
              width: mediaq.width,
              left: mediaq.width * 0.02,
              child: LottieBuilder.asset(
                'assets/LottiAnim/splashscreen.json',
                height: mediaq.height * 0.3,
                repeat: false,
              ),
            )
          ],
        ),
      ),
    );
  }
}
