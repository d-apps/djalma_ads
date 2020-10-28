import 'package:djalma_ads/djalma_ads.dart';
import 'package:flutter/material.dart';
import 'native_ad_screen.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  await Ads.init(nativeAds: true);
  await Ads.loadBanner();
  await Ads.loadInterstitial();
  await Ads.loadRewardedVideo();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Djalma Ads"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            RaisedButton(
              child: Text("Show Banner"),
              onPressed: ()=> Ads.showBanner(),
            ),

            RaisedButton(
              child: Text("Close Banner"),
              onPressed: ()=> Ads.closeBanner(),
            ),

            RaisedButton(
              child: Text("Show Interstitial"),
              onPressed: ()=> Ads.showInterstitial(),
            ),

            RaisedButton(
              child: Text("Show Rewarded"),
              onPressed: ()=> Ads.showRewarded(),
            ),

            RaisedButton(
              child: Text("Native Ads Screen"),
              onPressed: ()=> Navigator.push( context,
                  MaterialPageRoute(builder: (context) => NativeAdScreen())),

            ),

          ],
        ),
      ),
    );
  }
}

