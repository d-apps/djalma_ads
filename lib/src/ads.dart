import 'dart:io';

import 'package:djalma_ads/djalma_ads.dart';
import 'package:firebase_admob/firebase_admob.dart';

class Ads {

  // ignore: non_constant_identifier_names
  static String APP_ID;
  // ignore: non_constant_identifier_names
  static String BANNER_ID;
  // ignore: non_constant_identifier_names
  static String INTERSTITIAL_ID;
  // ignore: non_constant_identifier_names
  static String REWARDED_ID;
  // ignore: non_constant_identifier_names
  static String NATIVE_ID;

  static Future init(String appId, {String bannerId, String interstitialId,
                    String rewardedId, String nativeId, bool analytics}) async{

    // Set id for all type of ads

    APP_ID = appId;
    BANNER_ID = bannerId;
    INTERSTITIAL_ID = interstitialId;
    REWARDED_ID = rewardedId;
    NATIVE_ID = nativeId;

    // Initialize AdMob
    await FirebaseAdMob.instance.initialize(appId: appId, analyticsEnabled: analytics??false);


  }

  static BannerAd bannerAd;
  static InterstitialAd interstitialAd;

  Future loadBanner() async {

    bannerAd = BannerAd(

    );

  }

  static String getAppId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544~1458002511';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544~3347511713';
    }
    return null;
  }

  static String getBannerAdUnitId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/6300978111';
    }
    return null;
  }

  static String getInterstitialAdUnitId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/4411468910';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/1033173712';
    }
    return null;
  }

  static String getRewardBasedVideoAdUnitId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/1712485313';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/5224354917';
    }
    return null;
  }


}

MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(

  testDevices: <String>[

    "628CA97E938A7C380582DBF6F53279A1",
    "FC24EF68A748928ED0DBB45F3B2DA749",

  ], // Android emulators are considered test devices

);