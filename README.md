# djalma_ads

Djalma Ads is a package to make easier the implementation of calling methods from firebase_admob and native_flutter_admob
 libs.

## How to use

All needed methods are located in the class called Ads, all methods are static so you call them direcly.

First you have to call Ads.init(), this method initialize Firebase AdMob, all parameters from this method are optional, if you don't pass any parameter, all IDs will be testAdunit.

    ```
  await Ads.init(nativeAds: true); // Normally called on main.dart
    ´´´

Before showing the ads for the first it's necessary to load them except for native ads. (I call them on main.dart)

    ```
  await Ads.loadBanner();
  await Ads.loadInterstitial();
  await Ads.loadRewardedVideo();
    ´´´

After that you can call Ads.showSomething to show your ads.

    ```
  Ads.showBanner();
  Ads.showInterstitialAd();
  Ads.showRewarded();
  Ads.showBanner();
    ´´´

## Native Ads

For native ads please check the example to understand how native ads works.

