import 'dart:io';
import 'package:djalma_ads/djalma_ads.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';

class Ads {

  // ignore: non_constant_identifier_names
  static String _APP_ID = "";
  // ignore: non_constant_identifier_names
  static String _BANNER_ID = "";
  // ignore: non_constant_identifier_names
  static String _INTERSTITIAL_ID = "";
  // ignore: non_constant_identifier_names
  static String _REWARDED_ID = "";
  // ignore: non_constant_identifier_names
  //static String _NATIVE_ID = "";

  static bool _debug = false; // If debug is true, Ads listeners will print Ad events.

  static MobileAdTargetingInfo _mobileTargetingInfo; // TargetingInfo

  static Future<void> init(List<String> testDevices, {
    String appId = "",
    String bannerId = "",
    String interstitialId = "",
    String rewardedId = "",
    //String nativeId = "",
    bool analytics = false,
    bool debug = false,
    MobileAdTargetingInfo targetingInfo,
    }) async {

    // Set id for all type of ads

    _APP_ID = appId.isEmpty ? getAppTestId() : appId;
    _BANNER_ID = bannerId.isEmpty ? getBannerTestAdUnitId() : bannerId;
    _INTERSTITIAL_ID = interstitialId.isEmpty ? getInterstitialTestAdUnitId() : interstitialId;
    _REWARDED_ID = rewardedId.isEmpty ? getRewardedTestAdUnitId() : rewardedId;
    //_NATIVE_ID = nativeId.isEmpty ? getNativeTestAdUnitId() : nativeId;
    _mobileTargetingInfo = targetingInfo ?? MobileAdTargetingInfo(testDevices: testDevices);
    Ads._debug = debug;

    // Initialize AdMob
    await FirebaseAdMob.instance.initialize(appId: _APP_ID, analyticsEnabled: analytics);

  }

  // ======== Banner Ad =========

  static BannerAd bannerAd;
  static InterstitialAd interstitialAd;

  static Future<void> showBanner({
    AdSize adSize = AdSize.smartBanner,
    double anchorOffset = 0,
    double horizontalCenterOffset = 0,
    AnchorType anchorType = AnchorType.bottom}) async{

    bannerAd = BannerAd(
        adUnitId: _BANNER_ID,
        size: adSize,
        targetingInfo: _mobileTargetingInfo,
        listener: (MobileAdEvent mobileAdEvent){

          if(_debug){
            print("Banner event: $mobileAdEvent");
          }

        }
    );

    await bannerAd.load();

    bannerAd.show(
        anchorOffset: anchorOffset, // Posição Y
        anchorType: anchorType, // Where the ad will start
        horizontalCenterOffset: horizontalCenterOffset // Posição X
    );

  }

  static void closeBanner(){

    if(bannerAd != null){
      bannerAd.dispose();
    }

  }

  // ========= Interstitial Ad ===========

  static Future<void> loadInterstitial() async {

    interstitialAd = InterstitialAd(
      adUnitId: _INTERSTITIAL_ID,
      targetingInfo: _mobileTargetingInfo,
      listener: (MobileAdEvent mobileAdEvent){

        if(mobileAdEvent == MobileAdEvent.closed){
          loadInterstitial();
        }

        if(_debug){
          print("Interstitial event: $mobileAdEvent");
        }
      }
    );

    await interstitialAd.load();

  }

  static void showInterstitial({
    double anchorOffset = 0,
    double horizontalCenterOffset = 0,
    AnchorType anchorType = AnchorType.bottom}){

    interstitialAd.show(
        anchorOffset: anchorOffset,
        anchorType: anchorType,
        horizontalCenterOffset: horizontalCenterOffset
    );

  }

  // ============ Rewarded Ad ==============

  static Future<void> loadRewardedVideo({Function onRewarded}) async {

    await RewardedVideoAd.instance.load(
        adUnitId: _REWARDED_ID, targetingInfo: _mobileTargetingInfo
    );

    RewardedVideoAd.instance.listener =
        (RewardedVideoAdEvent event, {String rewardType = "coin", int rewardAmount = 0}){

      if(event == RewardedVideoAdEvent.rewarded){
        if(onRewarded != null){
          onRewarded();
        }
      }

      if(event == RewardedVideoAdEvent.closed){

        // Retrieve a new Rewarded Video Ad when user close
        RewardedVideoAd.instance.load(adUnitId: _REWARDED_ID);

      }

      if(_debug){
        print("RewardedVideo event: $event");
      }

    };

  }

  static void showRewarded(){
    RewardedVideoAd.instance.show();
  }

  // ============ Native Ad ==============

  /*
  static NativeAd getNativeAd(){

    return NativeAd(
      //adUnitId: _NATIVE_ID,
      factoryId: "",
      targetingInfo: _mobileTargetingInfo,
      listener: ((event){

      })
    );

  }
   */

 // ============ Test Ad Unit Ids ==============

  static getAppTestId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544~1458002511';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544~3347511713';
    }

  }

  static getBannerTestAdUnitId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/6300978111';
    }
  }

  static getInterstitialTestAdUnitId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/4411468910';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/1033173712';
    }

  }

  static getRewardedTestAdUnitId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/1712485313';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/5224354917';
    }

  }

  static getNativeTestAdUnitId() {

    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/3986624511';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/2247696110';
    }
  }

  // Get smart banner margin
  static double getMargin(BuildContext context){

    double height = MediaQuery.of(context).size.height;
    double margin = 0;

    if(height <= 400){

      margin = 32;

    } else if(height > 400 && height <= 720){

      margin = 60;

    } else if(height > 720){

      margin = 90;

    }

    return margin;

  }


}