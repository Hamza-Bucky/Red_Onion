import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lottie/lottie.dart';
import 'package:tunnel/controllers/location_controller.dart';
import 'package:tunnel/controllers/native_ad_controller.dart';
import 'package:tunnel/helpers/ad_helper.dart';
import 'package:tunnel/main.dart';
import '../widgets/vpn_card.dart';

class LocationScreen extends StatelessWidget {
  LocationScreen({super.key});
  final _controller = LocationController();
  final _adController = NativeAdController();

  @override
  Widget build(BuildContext context) {
    if (_controller.vpnList.isEmpty) {
      _controller.getVpnData();
    }
    _adController.ad = AdHelper.loadNativeAd(adController: _adController);
    return Obx(
      () => Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Live:${_controller.vpnList.length}',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'poppin',
                    color: Theme.of(context).LightText),
              ),
            ),
            title: Text(
              'Server Locations',
              style: TextStyle(
                  fontFamily: 'poppin',
                  fontWeight: FontWeight.w500,
                  fontSize: 23,
                  color: Theme.of(context).LightText),
            ),
            actions: [
              //REFRESH BUTTON
              IconButton(
                  onPressed: () {
                    _controller.getVpnData();
                    AdHelper.loadInterstitialAd(onComplete: () async {});
                  },
                  icon: Column(
                    children: [
                      Icon(
                        Icons.refresh_rounded,
                        size: 29,
                        color: Theme.of(context).LightText,
                      ),
                      Text(
                        'REFRESH',
                        style: TextStyle(
                            fontSize: 9,
                            fontFamily: 'poppin',
                            fontWeight: FontWeight.w900,
                            color: Theme.of(context).LightText),
                      )
                    ],
                  )),
            ],
          ),
          bottomNavigationBar:
              _adController.ad != null && _adController.adLoaded.isTrue
                  ? SafeArea(
                      child: SizedBox(
                          height: 90, child: AdWidget(ad: _adController.ad!)))
                  : null,
          body: _controller.isLoading.value
              ? _loadingWidget()
              : _controller.vpnList.isEmpty
                  ? _noVPNFound()
                  : _vpnData()),
    );
  }

  _vpnData() => Container(
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
        child: SafeArea(
          child: ListView.builder(
              itemCount: _controller.vpnList.length,
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.only(
                  top: mediaq.height * 0.03, bottom: mediaq.height * 0.09),
              itemBuilder: (context, ind) => VpnCard(
                    vpn: _controller.vpnList[ind],
                  )),
        ),
      );

  _loadingWidget() => Container(
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
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LottieBuilder.asset(
                'assets/LottiAnim/serverscreen.json',
                height: mediaq.height * 0.3,
              ),
              Text(
                'LOADING VPN LIST...',
                style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'poppin'),
              ),
            ],
          ),
        ),
      );

  _noVPNFound() => Center(
        child: Text(
          'VPNs Not Found :(',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w800, fontFamily: 'poppin'),
        ),
      );
}
