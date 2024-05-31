import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:tunnel/helpers/ad_helper.dart';
import 'package:tunnel/main.dart';
import 'package:tunnel/models/network_data.dart';
import 'package:tunnel/widgets/network_card.dart';

import '../apis/apis.dart';
import '../controllers/native_ad_controller.dart';
import '../models/ip_details.dart';

class NetworkTestScreen extends StatelessWidget {
  const NetworkTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _infoadController = NativeAdController();
    final ipData = IPDetails.fromJson({}).obs;
    APIs.getIPDetails(ipData: ipData);
    _infoadController.ad =
        AdHelper.loadNativeAd(adController: _infoadController);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Network test screen',
          style: TextStyle(fontFamily: 'poppin', fontWeight: FontWeight.w900),
        ),
        actions: [
          //REFRESH BUTTON
          IconButton(
              onPressed: () {
                ipData.value = IPDetails.fromJson({});
                APIs.getIPDetails(ipData: ipData);
              },
              icon: Icon(
                Icons.refresh_rounded,
                size: 29,
                color: Theme.of(context).LightText,
              )),
        ],
      ),
      bottomNavigationBar:
          _infoadController.ad != null && _infoadController.adLoaded.isTrue
              ? SafeArea(
                  child: SizedBox(
                      height: 90, child: AdWidget(ad: _infoadController.ad!)))
              : null,
      //REFRESH BUTTON
      body: Obx(
        () => Container(
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
          child: ListView(
            padding: EdgeInsets.only(
                left: mediaq.width * 0.08,
                right: mediaq.width * 0.08,
                top: mediaq.height * 0.2,
                bottom: mediaq.height * 0.2),
            physics: BouncingScrollPhysics(),
            children: [
              //IP Icon
              NetworkCard(
                data: NetworkData(
                    title: 'IP ADDRESS',
                    subtitle: ipData.value.query.isEmpty
                        ? 'Fetching'
                        : ipData.value.query,
                    icon: Icon(
                      Icons.my_location_rounded,
                      color: Theme.of(context).LightText,
                    )),
              ),
              //ISP
              NetworkCard(
                data: NetworkData(
                    title: 'INTERNET SERVICE PROVIDER',
                    subtitle: ipData.value.isp.isEmpty
                        ? 'Fetching'
                        : ipData.value.isp,
                    icon: Icon(
                      Icons.business,
                      color: Theme.of(context).LightText,
                    )),
              ),
              //Location
              NetworkCard(
                data: NetworkData(
                    title: 'LOCATION',
                    subtitle: ipData.value.country.isEmpty
                        ? 'Fetching'
                        : '${ipData.value.city},${ipData.value.regionName},${ipData.value.country}',
                    icon: Icon(
                      Icons.my_location_rounded,
                      color: Theme.of(context).LightText,
                    )),
              ),
              //PIN CODE
              NetworkCard(
                data: NetworkData(
                    title: 'IP ADDRESS',
                    subtitle: ipData.value.zip.isEmpty
                        ? 'Fetching'
                        : ipData.value.zip,
                    icon: Icon(
                      Icons.pin,
                      color: Theme.of(context).LightText,
                    )),
              ),
              //TIMEZONE
              NetworkCard(
                data: NetworkData(
                    title: 'TIME ZONE',
                    subtitle: ipData.value.timezone.isEmpty
                        ? 'Fetching'
                        : ipData.value.timezone,
                    icon: Icon(
                      Icons.timer,
                      color: Theme.of(context).LightText,
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
