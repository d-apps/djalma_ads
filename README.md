# djalma_ads

Djalma Ads is a package to make easier the implementation of calling methods from firebase_admob and native_flutter_admob
 libs.

## How to use

All needed methods are located in the class called Ads, all methods are static so you call them direcly.

First you have to call Ads.init(), this method initialize Firebase AdMob, all parameters from this method are optional, if you don't pass any parameter, all IDs will be testAdunit.

```dart
  await Ads.init(); // Normally called on main.dart
```

Before showing the ads for the first it's necessary to load them except for banner and native ads. (I call them on main.dart)

```dart
  await Ads.loadInterstitial();
  await Ads.loadRewardedVideo();
```

After that you can call Ads.showSomething to show your ads.

```dart
  Ads.showBanner();
  Ads.showInterstitialAd();
  Ads.showRewarded();
```

## getMargin

Method to get the height of smart banner for different devices.

```dart
Container(margin: EsdgeInsets.only(bottom: getMargin(context)))
```

