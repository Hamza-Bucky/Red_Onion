import 'dart:developer';
import 'dart:ui';

import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:tunnel/helpers/remote_config.dart';

import '../controllers/native_ad_controller.dart';

class AdHelper {
  static Future<void> initAds() async {
    await MobileAds.instance.initialize();
  }

  static InterstitialAd? _interstitialAd;
  static bool _interstitialAdLoaded = false;

  static NativeAd? _nativeAd;
  static bool _nativeAdLoaded = false;

  static void precacheInterstitialAd() {
    if (Config.hideAd) {
      return;
    }
    //MyDialogs.showProgress();
    log('Interstitial Ad Id:${Config.interstitialId}');
    InterstitialAd.load(
      adUnitId: Config.interstitialId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback =
              FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
            _resetinterstitialaAd();
            precacheInterstitialAd();
          });
          _interstitialAd = ad;
          _interstitialAdLoaded = true;
        },
        onAdFailedToLoad: (err) {
          _resetinterstitialaAd();
          print('Failed to load an interstitial ad: ${err.message}');
        },
      ),
    );
  }

  static void _resetinterstitialaAd() {
    _interstitialAd?.dispose();
    _interstitialAd = null;
    _interstitialAdLoaded = false;
  }

  static void loadInterstitialAd({required VoidCallback onComplete}) {
    if (Config.hideAd) {
      onComplete();
      return;
    }
    if (_interstitialAdLoaded && _interstitialAd != null) {
      _interstitialAd?.show();
      onComplete();
      return;
    }
    // MyDialogs.showProgress();
    log('Interstitial Ad Id:${Config.interstitialId}');
    InterstitialAd.load(
      adUnitId: Config.interstitialId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback =
              FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
            onComplete();
            _resetinterstitialaAd();
            precacheInterstitialAd();
          });
          Get.back();
          ad.show();
        },
        onAdFailedToLoad: (err) {
          Get.back();
          print('Failed to load an interstitial ad: ${err.message}');
          onComplete();
        },
      ),
    );
  }

  static void _resetNativeAd() {
    _nativeAd?.dispose();
    _nativeAd = null;
    _nativeAdLoaded = false;
  }

  static void precacheNativeAd() {
    if (Config.hideAd) {
      return;
    }

    log('Native Ad Id:${Config.nativeId}');

    _nativeAd = NativeAd(
        adUnitId: Config.nativeId,
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            print('$NativeAd loaded.');
            _nativeAdLoaded = true;
          },
          onAdFailedToLoad: (ad, error) {
            _resetNativeAd();
            // Dispose the ad here to free resources.
            print('$NativeAd failed to load: $error');
          },
        ),
        request: const AdManagerAdRequest(),
        // Styling
        nativeTemplateStyle: NativeTemplateStyle(
          templateType: TemplateType.small,
        ))
      ..load();
  }

  static NativeAd? loadNativeAd({required NativeAdController adController}) {
    if (Config.hideAd) {
      return null;
    }

    log('Native Ad Id:${Config.nativeId}');
    if (_nativeAdLoaded && _nativeAd != null) {
      adController.adLoaded.value = true;
      return _nativeAd;
    }
    return NativeAd(
        adUnitId: Config.nativeId,
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            print('$NativeAd loaded.');
            adController.adLoaded.value = true;
            _resetNativeAd();
            precacheNativeAd();
          },
          onAdFailedToLoad: (ad, error) {
            // Dispose the ad here to free resources.
            _resetNativeAd();
            print('$NativeAd failed to load: $error');
          },
        ),
        request: const AdManagerAdRequest(),
        // Styling
        nativeTemplateStyle: NativeTemplateStyle(
          templateType: TemplateType.small,
        ))
      ..load();
  }
}
