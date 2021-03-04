import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class Ads {

  // ignore: non_constant_identifier_names
  static String _APP_ID = "";
  // ignore: non_constant_identifier_names
  static String _ANDROID_APP_ID = "";
  // ignore: non_constant_identifier_names
  static String _IOS_APP_ID = "";
  // ignore: non_constant_identifier_names
  static String _ANDROID_BANNER_ID = "";
  // ignore: non_constant_identifier_names
  static String _IOS_BANNER_ID = "";
  // ignore: non_constant_identifier_names
  static String _ANDROID_INTERSTITIAL_ID = "";
  // ignore: non_constant_identifier_names
  static String _IOS_INTERSTITIAL_ID = "";
  // ignore: non_constant_identifier_names
  static String _ANDROID_REWARDED_ID = "";
  // ignore: non_constant_identifier_names
  static String _IOS_REWARDED_ID = "";
  // ignore: non_constant_identifier_names
  static String _ANDROID_NATIVE_ID = "";
  // ignore: non_constant_identifier_names
  static String _IOS_NATIVE_ID = "";

  static bool _debug = false; // If debug is true, Ads listeners will print Ad events.

  static AdRequest _adRequest;
  static BannerAd _bannerAd;
  static InterstitialAd _interstitialAd;
  static NativeAd _nativeAd;
  static RewardedAd _rewardedAd;

  static Future<void> init({
    String androidAppId = "",
    String androidBannerId = "",
    String androidInterstitialId = "",
    String androidRewardedId = "",
    String androidNativeId = "",
    String iosAppId = "",
    String iosBannerId = "",
    String iosInterstitialId = "",
    String iosRewardedId = "",
    String iosNativeId = "",
    bool analytics = false,
    bool debug = false,
    AdRequest adRequest = const AdRequest()
    }) async {

    // Set id for all type of ads

    _ANDROID_APP_ID = androidAppId.isEmpty ? getAppTestId() : androidAppId;
    _ANDROID_BANNER_ID = androidBannerId.isEmpty ? getBannerTestAdUnitId() : androidBannerId;
    _ANDROID_INTERSTITIAL_ID = androidInterstitialId.isEmpty ? getInterstitialTestAdUnitId() : androidInterstitialId;
    _ANDROID_REWARDED_ID = androidRewardedId.isEmpty ? getRewardedTestAdUnitId() : androidRewardedId;
    _ANDROID_NATIVE_ID = androidNativeId.isEmpty ? getNativeTestAdUnitId() : androidNativeId;

    _IOS_APP_ID = iosAppId.isEmpty ? getAppTestId() : iosAppId;
    _IOS_BANNER_ID = iosBannerId.isEmpty ? getBannerTestAdUnitId() : iosBannerId;
    _IOS_INTERSTITIAL_ID = iosInterstitialId.isEmpty ? getInterstitialTestAdUnitId() : iosInterstitialId;
    _IOS_REWARDED_ID = iosRewardedId.isEmpty ? getRewardedTestAdUnitId() : iosRewardedId;
    _IOS_NATIVE_ID = iosNativeId.isEmpty ? getNativeTestAdUnitId() : iosNativeId;

    Ads._debug = debug;

    if(Platform.isAndroid){
      _APP_ID = androidAppId.isEmpty ? getAppTestId() : androidAppId;
    } else if(Platform.isIOS){
      _APP_ID = iosAppId.isEmpty ? getAppTestId() : iosAppId;
    }

    _adRequest = adRequest;

    // Initialize AdMob
    await MobileAds.instance.initialize();

  }

  // ======== Banner Ad =========


  static Future<Widget> getBannerWidget({@required BuildContext context, AdSize adSize}) async{

    _bannerAd = BannerAd(
      adUnitId: getBannerAdUnitId(),
      size: adSize ?? AdSize.smartBanner,
      request: _adRequest,
      listener: AdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (Ad ad) {

          if(_debug){
            print('Ad loaded.');
          }

        },
        // Called when an ad request failed.
        onAdFailedToLoad: (Ad ad, LoadAdError error) {

          if(_debug){
            print('Ad failed to load: $error');
            _bannerAd.dispose();
          }

        },
        // Called when an ad opens an overlay that covers the screen.
        onAdOpened: (Ad ad) {

          if(_debug){
            print('Ad opened.');
          }

        },
        // Called when an ad removes an overlay that covers the screen.
        onAdClosed: (Ad ad) {

          if(_debug){
            print('Ad closed.');
          }

        },
        // Called when an ad is in the process of leaving the application.
        onApplicationExit: (Ad ad) {

          if(_debug){
            print('Left application.');
          }

        },
      ),
    );

    await _bannerAd.load();

    print("BANNER SIZE HEIGHT: ${_bannerAd.size.height}");
    print("BANNER SIZE WIDTH: ${_bannerAd.size.width}");

    return Container(
        child: AdWidget(ad: _bannerAd),
        constraints: BoxConstraints(
          maxHeight: 90,
          maxWidth: MediaQuery.of(context).size.width,
          minHeight: 32,
          minWidth: MediaQuery.of(context).size.width,
        ),
    );

  }

  // ============ Interstitial Ad ==============

  static Future<void> loadInterstitial() async {

    _interstitialAd = InterstitialAd(
      adUnitId: getInterstitialAdUnitId(),
      request: _adRequest,
      listener: AdListener(
        onAdLoaded: (Ad ad) {

          if(_debug){
            print('${ad.runtimeType} loaded.');
          }

        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          if(_debug){
            print('${ad.runtimeType} failed to load: $error.');
          }
          ad.dispose();
          _interstitialAd = null;
          loadInterstitial();
        },
        onAdOpened: (Ad ad) => print('${ad.runtimeType} onAdOpened.'),
        onAdClosed: (Ad ad) {
          if(_debug){
            print('${ad.runtimeType} closed.');
          }
          ad.dispose();
          loadInterstitial();
        },
        onApplicationExit: (Ad ad) {
          if(_debug){
            print('${ad.runtimeType} onApplicationExit.');
          }
        }
      ),
    );

    await _interstitialAd.load();

  }

  static void showInterstitial() {

    _interstitialAd.show();

  }

  Future<void> loadNative() async{

    _nativeAd = NativeAd(
      adUnitId: getNativeTestAdUnitId(),
      request: _adRequest,
      factoryId: 'adFactoryExample',
      listener: AdListener(
        onAdLoaded: (Ad ad) {
          print('$NativeAd loaded.');

        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('$NativeAd failedToLoad: $error');

        },
        onAdOpened: (Ad ad) => print('$NativeAd onAdOpened.'),
        onAdClosed: (Ad ad) => print('$NativeAd onAdClosed.'),
        onApplicationExit: (Ad ad) => print('$NativeAd onApplicationExit.'),
      ),
    );

    await _nativeAd.load();

  }

  static Widget getNativeWidget(Key key){
    return AdWidget(ad: _nativeAd, key: key);
  }

  // ============ Native Ad ==============

  // ============ Rewarded Ad ==============


  static Future<void> loadRewardedVideo({Function onRewarded}) async {

    _rewardedAd = RewardedAd(
      adUnitId: getRewardedAdUnitId(),
      request: _adRequest,
      listener: AdListener(
        onAdFailedToLoad: (Ad ad, LoadAdError error){

          if(_debug){
            print("onAdFailedToLoad: ${error.message}");
          }

        },
        onAdClosed: (Ad ad) {

          if(_debug){
            print("onAdClosed");
          }

        },
        onRewardedAdUserEarnedReward: (RewardedAd ad, RewardItem reward) {
          print(reward.type);
          print(reward.amount);
        },
      ),
    );




  }

  static void showRewarded(){
    _rewardedAd.show();
  }


  // ========= Get Real IDs ==============

  static getAppId() {
    if (Platform.isIOS) {
      return _IOS_APP_ID;
    } else if (Platform.isAndroid) {
      return _ANDROID_APP_ID;
    }

  }

  static getBannerAdUnitId() {
    if (Platform.isIOS) {
      return _IOS_BANNER_ID;
    } else if (Platform.isAndroid) {
      return _ANDROID_BANNER_ID;
    }
  }

  static getInterstitialAdUnitId() {
    if (Platform.isIOS) {
      return _IOS_INTERSTITIAL_ID;
    } else if (Platform.isAndroid) {
      return _ANDROID_INTERSTITIAL_ID;
    }

  }

  static getRewardedAdUnitId() {
    if (Platform.isIOS) {
      return _IOS_REWARDED_ID;
    } else if (Platform.isAndroid) {
      return _ANDROID_REWARDED_ID;
    }

  }

  static getNativeAdUnitId() {
    if (Platform.isIOS) {
      return _IOS_NATIVE_ID;
    } else if (Platform.isAndroid) {
      return _ANDROID_NATIVE_ID;
    }

  }


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