import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:tunnel/helpers/ad_helper.dart';
import 'package:tunnel/screens/splashscreen.dart';
import 'helpers/pref.dart';
import 'helpers/remote_config.dart';

//variable to get the screen size
late Size mediaq;
Future<void> main() async {
  //To initialize the bindings
  WidgetsFlutterBinding.ensureInitialized();
  //TO START PROJECT IN FULL SCREEN MODE
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

// ...
  MobileAds.instance.initialize();
  await Firebase.initializeApp();

  await Config.initConfig();

  await Pref.initializeHive();

  await AdHelper.initAds();
//SET ORIENTATION TYPE
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((v) {
    runApp(const MyApp());
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Red Onion',

      home: splashscreen(),
      //SIMPLY A THEME
      theme: ThemeData(
          fontFamily: 'poopin',
          appBarTheme: AppBarTheme(centerTitle: true, elevation: 7)),
      themeMode: Pref.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      //DARK THEME
      darkTheme: ThemeData(
          fontFamily: 'poppin',
          brightness: Brightness.dark,
          appBarTheme: AppBarTheme(centerTitle: true, elevation: 7)),
    );
  }
}

//CREATING CUSTOM COLOR OF CHANGING DARK MODE
extension AppTheme on ThemeData {
  Color get LightText => Pref.isDarkMode ? Colors.white : Colors.black;
}
