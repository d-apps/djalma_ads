import 'dart:io';

import 'package:djalma_ads/djalma_ads.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:native_flutter_admob/native_flutter_admob.dart';

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

  static bool debug; // If debug is true, Ads listeners will print Ad Events.

  static Future init({String appId, String bannerId, String interstitialId,
                      String rewardedId, String nativeId, bool analytics,
                      bool debug, bool nativeAds = false}) async {

    // Set id for all type of ads

    APP_ID = appId??getAppId();
    BANNER_ID = bannerId??getBannerAdUnitId();
    INTERSTITIAL_ID = interstitialId??getInterstitialAdUnitId();
    REWARDED_ID = rewardedId??getRewardedAdUnitId();
    NATIVE_ID = nativeId??getNativeAdUnitId();

    Ads.debug = debug??true;

    // Initialize AdMob
    await FirebaseAdMob.instance.initialize(appId: APP_ID, analyticsEnabled: analytics??false);

    // Initialization for native ads
    if(nativeAds){
      await NativeAdmob().initialize(appID: APP_ID);
    }


  }

  static BannerAd bannerAd;
  static InterstitialAd interstitialAd;

  static Future loadBanner() async {

    bannerAd = BannerAd(
      adUnitId: BANNER_ID,
      size: AdSize.smartBanner,
      listener: (MobileAdEvent mobileAdEvent){

        if(debug){
          print("Banner event: $mobileAdEvent");
        }

      }
    );

    await bannerAd.load();

  }

  static Future showBanner({double anchorOffset, double horizontalCenterOffset, AnchorType anchorType}) async{

    if(bannerAd == null){

      await loadBanner().then((_) => bannerAd.show(
          anchorOffset: anchorOffset??0,
          anchorType: anchorType??AnchorType.bottom,
          horizontalCenterOffset: horizontalCenterOffset??0
      ));

    } else {

      bannerAd.show(
          anchorOffset: anchorOffset??0,
          anchorType: anchorType??AnchorType.bottom,
          horizontalCenterOffset: horizontalCenterOffset??0
      );

    }

  }

  static void closeBanner(){

    bannerAd.dispose();
    bannerAd = null;

  }

  // ====================

  static Future loadInterstitial() async {

    interstitialAd = InterstitialAd(
      adUnitId: INTERSTITIAL_ID,
      listener: (MobileAdEvent mobileAdEvent){

        if(mobileAdEvent == MobileAdEvent.closed){
          loadInterstitial();
        }

        if(debug){
          print("Interstitial event: $mobileAdEvent");
        }
      }
    );

    await interstitialAd.load();

  }

  static void showInterstitial(){

    interstitialAd.show();

  }

  // ==========================

  static Future loadRewardedVideo({Function function}) async {

    await RewardedVideoAd.instance.load(adUnitId: REWARDED_ID);

    RewardedVideoAd.instance.listener = (RewardedVideoAdEvent event, {String rewardType, int rewardAmount}){

      if(function != null){
        function();
      }

      if(event == RewardedVideoAdEvent.closed){

        RewardedVideoAd.instance.load(adUnitId: REWARDED_ID)
            .catchError((e) => print("Error while loading another REWARDED AD!"));

      }

      if(debug){
        print("RewardedVideo event: $event");
      }

    };

  }

  static void showRewarded(){
    RewardedVideoAd.instance.show();
  }

  // ==========================

  static NativeAdmobBannerView getNativeAdmobBannerView(
      {EdgeInsets contentPadding, bool showMedia, BannerStyle bannerStyle}){

    return NativeAdmobBannerView(
      adUnitID: NATIVE_ID,
      contentPadding: contentPadding??EdgeInsets.all(8.0),
      showMedia: showMedia??true,
      style: bannerStyle??BannerStyle.dark,
    );

  }

 // ==========================

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

  static String getRewardedAdUnitId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/1712485313';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/5224354917';
    }
    return null;
  }

  static String getNativeAdUnitId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/3986624511';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/2247696110';
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