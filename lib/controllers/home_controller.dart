import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tunnel/helpers/ad_helper.dart';
import 'package:tunnel/helpers/snack_bar.dart';

import '../helpers/pref.dart';
import '../models/vpn.dart';
import '../models/vpn_config.dart';
import '../services/vpn_engine.dart';

class HomeController extends GetxController {
  final Rx<Vpn> vpn = Pref.vpn.obs;

  final vpnState = VpnEngine.vpnDisconnected.obs;

  void connectToVpn() {
    if (vpn.value.openVPNConfigDataBase64.isEmpty) {
      MyDialogs.info(
          prompt: 'Select a Location by clicking on \'Change Location\'');
      return;
    }

    if (vpnState.value == VpnEngine.vpnDisconnected) {
      final data = Base64Decoder().convert(vpn.value.openVPNConfigDataBase64);
      final config = Utf8Decoder().convert(data);
      final vpnConfig = VpnConfig(
          country: vpn.value.countryLong,
          username: 'vpn',
          password: 'vpn',
          config: config);

      ///Start if stage is disconnected
      AdHelper.loadInterstitialAd(onComplete: () async {
        await VpnEngine.startVpn(vpnConfig);
      });
    } else {
      ///Stop if stage is "not" disconnected

      VpnEngine.stopVpn();
    }
  }

  Future<void> privat_connectToVpn() async {
    if (vpn.value.openVPNConfigDataBase64.isEmpty) {
      MyDialogs.info(
          prompt: 'Select a Location by clicking on \'Change Location\'');
      return;
    }

    if (vpnState.value == VpnEngine.vpnDisconnected) {
      final vpnConfig = VpnConfig(
          country: 'France',
          username: 'vpn2024',
          password: 'vpn2024',
          config: await rootBundle.loadString('assets/vpn/france.ovpn'));

      ///Start if stage is disconnected
      AdHelper.loadInterstitialAd(onComplete: () async {
        await VpnEngine.startVpn(vpnConfig);
      });
    } else {
      ///Stop if stage is "not" disconnected

      VpnEngine.stopVpn();
    }
  }

  //CHANGING THE BUTTON COLOR ON TAP
  Color get getButtonColor {
    switch (vpnState.value) {
      case VpnEngine.vpnDisconnected:
        return Color(0xffffa58d);
      case VpnEngine.vpnConnected:
        return Color(0xfffc4584);

      default:
        return Color(0xfffc7c8c);
    }
  }

  //VPN BUTTON TEXT
  String get getButtonText {
    switch (vpnState.value) {
      case VpnEngine.vpnDisconnected:
        return 'Tap To Connect';
      case VpnEngine.vpnConnected:
        return 'Disconnect';

      default:
        return 'Connecting...';
    }
  }
}
