import 'dart:developer';

import 'package:firebase_remote_config/firebase_remote_config.dart';

class Config {
  static final _config = FirebaseRemoteConfig.instance;
  static const _defaultValues = {
    "Interstitial_Ads": "ca-app-pub-3940256099942544/1033173712",
    "Native_Ads": "/6499/example/native",
    "Show_Ads": true
  };
  static Future<void> initConfig() async {
    await _config.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(minutes: 30)));
    await _config.setDefaults(_defaultValues);
    await _config.fetchAndActivate();
    log('updated:${_config.getBool('Show_Ads')}');

    _config.onConfigUpdated.listen((event) async {
      await _config.activate();
      log('updated:${_config.getBool('Show_Ads')}');

      // Use the new config values here.
    });
  }

  static bool get _showAd => _config.getBool('Show_Ads');
  static String get nativeId => _config.getString('Native_Ads');
  static String get interstitialId => _config.getString('Interstitial_Ads');

  static bool get hideAd => !_showAd;
}
