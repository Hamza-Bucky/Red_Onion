import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tunnel/controllers/home_controller.dart';
import 'package:tunnel/main.dart';
import 'package:tunnel/screens/location_screen.dart';
import 'package:tunnel/screens/network_informationIcon.dart';
import 'package:tunnel/screens/private_screen.dart';
import 'package:tunnel/widgets/homecard.dart';
import 'package:tunnel/widgets/timer.dart';

import '../helpers/ad_helper.dart';
import '../helpers/pref.dart';
import '../models/vpn_status.dart';
import '../services/vpn_engine.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final _controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    ///Add listener to update vpn state
    VpnEngine.vpnStageSnapshot().listen((event) {
      _controller.vpnState.value = event;
    });

    return Scaffold(
      extendBodyBehindAppBar: true,
      //SETTING UP APP BAR FOR THE HOME SCREEN
      appBar: AppBar(
        elevation: 0,

        backgroundColor: Colors.transparent,
        //HOME BUTTON
        leading: Column(
          children: [
            IconButton(
                onPressed: () {
                  Get.to(() => PrivateLocationScreen());
                },
                icon: ImageIcon(
                  AssetImage('assets/icons/secure.png'),
                  color: Theme.of(context).LightText,
                  size: 24,
                )),
          ],
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ShaderMask(
                shaderCallback: (Rect bounds) {
                  return LinearGradient(
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft,
                          colors: [Colors.white, Colors.white, Colors.white60])
                      .createShader(bounds);
                },
                blendMode: BlendMode.dstIn,
                child: Text(
                  'Red',
                  style: TextStyle(
                      fontFamily: 'poppin',
                      fontWeight: FontWeight.w900,
                      color: Theme.of(context).LightText,
                      letterSpacing: 5),
                )),
            SizedBox(
              width: mediaq.width * 0.01,
            ),
            Image(
              image: AssetImage('assets/images/red-onion.png'),
              height: mediaq.height * 0.06,
              width: mediaq.width * 0.06,
              color: Theme.of(context).LightText,
            ),
            ShaderMask(
                shaderCallback: (Rect bounds) {
                  return LinearGradient(
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft,
                          colors: [Colors.white60, Colors.white, Colors.white])
                      .createShader(bounds);
                },
                blendMode: BlendMode.dstIn,
                child: Text(
                  'nion',
                  style: TextStyle(
                    fontFamily: 'poppin',
                    fontWeight: FontWeight.w900,
                    color: Theme.of(context).LightText,
                    letterSpacing: 5,
                  ),
                )),
          ],
        ),
        actions: [
          //BRIGTHNESS BUTTON
          IconButton(
              onPressed: () {
                Get.changeThemeMode(
                    Pref.isDarkMode ? ThemeMode.light : ThemeMode.dark);
                Pref.isDarkMode = !Pref.isDarkMode;
              },
              icon: Icon(
                Icons.brightness_medium_rounded,
                size: 23,
                color: Theme.of(context).LightText,
              )),
          //INFO BUTTON
          IconButton(
              onPressed: () {
                Get.to(() => NetworkTestScreen());
                AdHelper.loadInterstitialAd(onComplete: () async {});
              },
              icon: Icon(
                Icons.info_rounded,
                size: 23,
                color: Theme.of(context).LightText,
              )),
        ],
      ),
      bottomNavigationBar: _changeLocation(context),

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
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Obx(() => vpnButton(context)),
          //COUNTER FOR TIME ><><>><<TIMER
          //LOWER PORTION OF CONNECT BUTTON STARTS HERE<><><><><><><><><><><<><><><><><><><><><>ADDING HOME CARDS
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HomeCard(
                    title: _controller.vpn.value.countryLong.isEmpty
                        ? 'Country'
                        : _controller.vpn.value.countryLong,
                    subtitle: '',
                    icon: CircleAvatar(
                      backgroundColor: Color(0xfffc8f94),
                      child: _controller.vpn.value.countryLong.isEmpty
                          ? Icon(Icons.vpn_lock, size: 35)
                          : null,
                      backgroundImage: _controller.vpn.value.countryLong.isEmpty
                          ? null
                          : AssetImage(
                              'assets/flags/${_controller.vpn.value.countryShort.toLowerCase()}.png'),
                    )),
                HomeCard(
                    title: _controller.vpn.value.countryLong.isEmpty
                        ? 'Ping'
                        : '${_controller.vpn.value.ping} ms',
                    subtitle: '',
                    icon: CircleAvatar(
                      backgroundColor: Color(0xfffc7c8c),
                      child: ImageIcon(
                        AssetImage('assets/icons/3d.png'),
                        size: 34,
                        color: Theme.of(context).LightText,
                      ),
                    ))
              ],
            ),
          ),
          SizedBox(
            height: mediaq.width * 0.01,
          ),
          //MAking home icons dynamic
          StreamBuilder<VpnStatus?>(
            initialData: VpnStatus(),
            stream: VpnEngine.vpnStatusSnapshot(),
            builder: (context, snapshot) => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HomeCard(
                  //dynamic download bit
                  title: '${snapshot.data?.byteIn ?? 'Download'}',
                  subtitle: '',
                  icon: ImageIcon(
                    AssetImage('assets/icons/downloads.png'),
                    size: 34,
                    color: Theme.of(context).LightText,
                  ),
                ),
                HomeCard(
                    //dynamic upload bit
                    title: '${snapshot.data?.byteOut ?? 'Upload'}',
                    subtitle: '',
                    icon: CircleAvatar(
                      backgroundColor: Color(0xfff86289),
                      child: ImageIcon(
                        AssetImage('assets/icons/up-loading.png'),
                        size: 34,
                        color: Theme.of(context).LightText,
                      ),
                    ))
              ],
            ),
          ),
        ]),
      ),
    );
  }

//DESIGNING MY VPN BUTTON
  Widget vpnButton(BuildContext context) => Column(
        children: [
          InkWell(
            onTap: () {
              _controller.connectToVpn();
            },
            borderRadius: BorderRadius.circular(150),
            child: Container(
              margin: EdgeInsets.only(top: mediaq.height * 0.17),
              //THIRD LAYER OF CONTAINER
              padding: EdgeInsets.all(17),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _controller.getButtonColor.withOpacity(0.5)),
              child: Container(
                //SECOND LAYER OF BUTTON
                padding: EdgeInsets.all(17),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _controller.getButtonColor.withOpacity(0.2)),
                child: Container(
                  //FIRST LAYER OF BUTTON
                  width: mediaq.height * 0.17,
                  height: mediaq.height * 0.17,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _controller.getButtonColor),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.power_settings_new_rounded,
                        size: 27,
                        color: Theme.of(context).LightText,
                      ),
                      SizedBox(
                        height: 11,
                      ),
                      //BUTTON TEXT
                      Text(
                        _controller.getButtonText,
                        style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).LightText,
                            fontFamily: 'poppin'),
                      ),
                      Obx(() => timer(
                          startTimer: _controller.vpnState.value ==
                              VpnEngine.vpnConnected)),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
              //DISCONNECT BUTTON
              margin: EdgeInsets.all(7),
              padding: EdgeInsets.all(11),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(21)),
              //DISCONNECT BUTTON
              child: Text(
                _controller.vpnState.value == VpnEngine.vpnDisconnected
                    ? 'Not Connected'
                    : _controller.vpnState.replaceAll('_', '').toUpperCase(),
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).LightText,
                    fontFamily: 'poppin'),
              ))
        ],
      );

  //BOTTOM BAR FOR CHANING LOCATION ><><>><><><><><><><><<><><><><><><>
  Widget _changeLocation(BuildContext context) => SafeArea(
        child: InkWell(
          onTap: () => Get.to(() => LocationScreen()),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Color(0xfffc4584)),
                gradient: LinearGradient(
                  colors: [
                    Color(0xfffc4584),
                    Color(0xfffc4584),
                    Color(0xfffc4584),
                    Color(0xfffc4584)
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.bottomRight,
                  transform: GradientRotation(0.7),
                )),
            padding: EdgeInsets.all(mediaq.width * 0.035),
            height: mediaq.height * 0.08,
            child: Row(
              children: [
                ImageIcon(
                  AssetImage('assets/icons/connection.png'),
                  color: Theme.of(context).LightText,
                  size: 40,
                ),
                SizedBox(
                  width: mediaq.width * 0.02,
                ),
                //BOTTOM BAR TEXT
                Text(
                  'CHANGE LOCATION',
                  style: TextStyle(
                      color: Theme.of(context).LightText,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'poppin',
                      letterSpacing: 2),
                ),
                Spacer(),
                //BOTTOM BAR ICON
                CircleAvatar(
                  backgroundColor: Color(0xfffc4584),
                  child: Icon(
                    Icons.keyboard_arrow_right_rounded,
                    size: 35,
                    color: Theme.of(context).LightText,
                  ),
                )
              ],
            ),
          ),
        ),
      );
}
