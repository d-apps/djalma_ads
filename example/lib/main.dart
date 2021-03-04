import 'dart:ui';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:djalma_ads/djalma_ads.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  // No Ad Units were passed, Test Ad Units will be used instead
  await Ads.init(
    adRequest: AdRequest(
      testDevices: ["FC24EF68A748928ED0DBB45F3B2DA749"]
    ),
    debug: true,
  );

  await Ads.loadBanner();
  await Ads.loadInterstitial();
  /*
    Ads.loadRewardedVideo( onRewarded: () {

      print("onRewarded!!!");
      setState(() {
        coins++;
      });

    });
     */

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

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int coins = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Row(
          children: [

            SizedBox(width: 16),
            Icon(FontAwesomeIcons.coins),
            SizedBox(width: 5),
            Text("$coins")

          ],
        ),
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

              Text("SMART BANNER"),

              Ads.getBannerWidget(Key("0")),

              ElevatedButton(
                child: Text("SHOW INTERSTITIAL"),
                onPressed: (){
                  Ads.showInterstitial();
                },
              ),

              Text("SMART BANNER"),

              //Ads.getBannerWidget(Key("1")),

            ],
          ),
        ),
      ),
    );
  }
}

