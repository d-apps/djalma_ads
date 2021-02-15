import 'dart:ui';

import 'package:djalma_ads/djalma_ads.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  // No Ad Units were passed, Test Ad Units will be used instead
  await Ads.init(
    ["FC24EF68A748928ED0DBB45F3B2DA749"], // List of Test Devices ID
    debug: true,
  );

  await Ads.loadInterstitial();
  await Ads.loadRewardedVideo( onRewarded: () => print("onRewarded!!!") );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
        padding: EdgeInsets.only(bottom: Ads.getMargin(context)),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              ElevatedButton(
                child: Text("Close Banner"),
                onPressed: ()=> Ads.closeBanner(),
              ),

              ElevatedButton(
                child: Text("Show Banner"),
                onPressed: ()=> Ads.showBanner(
                  adSize: AdSize.banner,
                ),
              ),

              ElevatedButton(
                child: Text("Show Smart Banner"),
                onPressed: ()=> Ads.showBanner(adSize: AdSize.smartBanner),
              ),

              ElevatedButton(
                child: Text("Show Medium Rectangle Banner"),
                onPressed: ()=> Ads.showBanner(
                  adSize: AdSize.mediumRectangle,
                ),
              ),

              ElevatedButton(
                child: Text("Show Full Banner"),
                onPressed: ()=> Ads.showBanner(adSize: AdSize.fullBanner),
              ),

              ElevatedButton(
                child: Text("Show Large Banner"),
                onPressed: ()=> Ads.showBanner(adSize: AdSize.largeBanner),
              ),

              ElevatedButton(
                child: Text("Show Leaderboard Banner"),
                onPressed: ()=> Ads.showBanner(adSize: AdSize.leaderboard),
              ),

              ElevatedButton(
                child: Text("Show Interstitial"),
                onPressed: ()=> Ads.showInterstitial(
                  anchorType: AnchorType.top,
                  anchorOffset: 0,
                  horizontalCenterOffset: 0
                ),
              ),

              ElevatedButton(
                child: Text("Show Rewarded"),
                onPressed: ()=> Ads.showRewarded(),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

