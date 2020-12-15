import 'dart:io';

import 'package:djalma_ads/djalma_ads.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admob_app_open/flutter_admob_app_open.dart';
import 'package:native_flutter_admob/native_flutter_admob.dart';

class Ads {

  // ignore: non_constant_identifier_names
  static String APP_ID = "";
  // ignore: non_constant_identifier_names
  static String BANNER_ID = "";
  // ignore: non_constant_identifier_names
  static String INTERSTITIAL_ID = "";
  // ignore: non_constant_identifier_names
  static String REWARDED_ID = "";
  // ignore: non_constant_identifier_names
  static String NATIVE_ID = "";
  // ignore: non_constant_identifier_names
  static String APPOPEN_ID = "";

  static bool debug = false; // If debug is true, Ads listeners will print Ad Events.

  static var mobileTargetingInfo; // TargetingInfo

  static Future init(List<String> testDevices, {String appId = "", String bannerId = "",
                      String interstitialId = "", String rewardedId = "", String nativeId = "",
                      bool analytics = false, bool debug = false, bool nativeAds = false,
                      /*bool appOpen = false, String appOpenId = "",*/ }) async {

    // Set id for all type of ads

    APP_ID = appId.isEmpty?getAppId():appId;
    BANNER_ID = bannerId.isEmpty?getBannerAdUnitId():bannerId;
    INTERSTITIAL_ID = interstitialId.isEmpty?getInterstitialAdUnitId():interstitialId;
    REWARDED_ID = rewardedId.isEmpty?getRewardedAdUnitId():rewardedId;
    NATIVE_ID = nativeId.isEmpty?getNativeAdUnitId():nativeId;
    //APPOPEN_ID = appOpenId.isEmpty?getAppOpenAdUnitId():appOpenId;

    Ads.debug = debug;

    mobileTargetingInfo = MobileAdTargetingInfo(
      testDevices: testDevices
    );

    // Initialize AdMob
    await FirebaseAdMob.instance.initialize(appId: APP_ID, analyticsEnabled: analytics);

    // Initialization for native ads
    if(nativeAds){
      await NativeAdmob().initialize(appID: APP_ID);
    }

    // Initialization App Open
    /*
    if(appOpen){
      await FlutterAdmobAppOpen.instance.initialize(
        appId: APP_ID,
        appAppOpenAdUnitId: APPOPEN_ID,
        targetingInfo: mobileTargetingInfo
      );
    }
     */


  }

  static BannerAd bannerAd = BannerAd(adUnitId: "", size: AdSize.smartBanner);
  static InterstitialAd interstitialAd = InterstitialAd();


  static Future showBanner({double anchorOffset = 0, double horizontalCenterOffset = 0, AnchorType anchorType = AnchorType.bottom}) async{

    bannerAd = BannerAd(
        adUnitId: BANNER_ID,
        size: AdSize.smartBanner,
        targetingInfo: mobileTargetingInfo,
        listener: (MobileAdEvent mobileAdEvent){

          if(debug){
            print("Banner event: $mobileAdEvent");
          }

        }
    );

    await bannerAd.load();

    bannerAd.show(
        anchorOffset: anchorOffset,
        anchorType: anchorType,
        horizontalCenterOffset: horizontalCenterOffset
    );

  }

  static void closeBanner(){

    bannerAd.dispose();

  }

  // ====================

  static Future loadInterstitial() async {

    interstitialAd = InterstitialAd(
      adUnitId: INTERSTITIAL_ID,
      targetingInfo: mobileTargetingInfo,
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

  static Future loadRewardedVideo(Function function) async {

    await RewardedVideoAd.instance.load(adUnitId: REWARDED_ID);

    RewardedVideoAd.instance.listener = (RewardedVideoAdEvent event, {String rewardType = "", int rewardAmount = 0}){


     function();


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
      {EdgeInsets contentPadding = const EdgeInsets.all(0), bool showMedia = true, BannerStyle bannerStyle = BannerStyle.light}){

    return NativeAdmobBannerView(
      adUnitID: NATIVE_ID,
      contentPadding: contentPadding,
      showMedia: showMedia,
      style: bannerStyle,
    );

  }

 // ==========================

  static getAppId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544~1458002511';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544~3347511713';
    }

  }

  static getBannerAdUnitId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/6300978111';
    }
  }

  static getInterstitialAdUnitId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/4411468910';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/1033173712';
    }

  }

  static getRewardedAdUnitId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/1712485313';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/5224354917';
    }

  }

  static getNativeAdUnitId() {

    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/3986624511';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/2247696110';
    }
  }

  static String getAppOpenAdUnitId() {
    return FlutterAdmobAppOpen.testAppOpenAdId;
  }


}