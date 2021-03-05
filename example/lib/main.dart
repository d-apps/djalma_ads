import 'dart:ui';
import 'package:example/banner_native_ad_screen.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:djalma_ads/djalma_ads.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  // No Ad Units were passed, Test Ad Units will be used instead
  await Ads.init(
    adRequest: AdRequest(
      testDevices: ["FC24EF68A748928ED0DBB45F3B2DA749"]
    ),
    debug: true,
  );

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
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Text("BANNER"),

              SizedBox(height: 15),

              FutureBuilder<Widget>(
                future: Ads.getBannerWidget(
                    context: context,
                    adSize: AdSize.banner
                ),
                builder: (_, snapshot){

                  if(!snapshot.hasData){

                    return Text("Carregando...");

                  } else {

                    return Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: snapshot.data,
                    );

                  }

                },
              ),

              SizedBox(height: 15),

              Text("LARGE BANNER"),

              SizedBox(height: 15),

              FutureBuilder<Widget>(
                future: Ads.getBannerWidget(
                    context: context,
                    adSize: AdSize.largeBanner
                ),
                builder: (_, snapshot){

                  if(!snapshot.hasData){

                    return Text("Carregando...");

                  } else {

                    return Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      child: snapshot.data,
                    );

                  }

                },
              ),

              SizedBox(height: 15),

              Text("MEDIUM RECTANGLE BANNER"),

              SizedBox(height: 15),

              FutureBuilder<Widget>(
                future: Ads.getBannerWidget(
                    context: context,
                    adSize: AdSize.mediumRectangle
                ),
                builder: (_, snapshot){

                  if(!snapshot.hasData){

                    return Text("Carregando...");

                  } else {

                    return Container(
                      height: 250,
                      width: MediaQuery.of(context).size.width,
                      child: snapshot.data,
                    );

                  }

                },
              ),

              SizedBox(height: 15),

              Text("FULL BANNER"),

              SizedBox(height: 15),

              FutureBuilder<Widget>(
                future: Ads.getBannerWidget(
                    context: context,
                    adSize: AdSize.fullBanner
                ),
                builder: (_, snapshot){

                  if(!snapshot.hasData){

                    return Text("Carregando...");

                  } else {

                    return Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      child: snapshot.data,
                    );

                  }

                },
              ),

              SizedBox(height: 15),

              Text("LEADERBOARD BANNER"),

              SizedBox(height: 15),

              FutureBuilder<Widget>(
                future: Ads.getBannerWidget(
                    context: context,
                    adSize: AdSize.leaderboard
                ),
                builder: (_, snapshot){

                  if(!snapshot.hasData){

                    return Text("Carregando...");

                  } else {

                    return Container(
                      height: 90,
                      width: MediaQuery.of(context).size.width,
                      child: snapshot.data,
                    );

                  }

                },
              ),

              SizedBox(height: 15),

              Text("SMART BANNER"),

              SizedBox(height: 15),

              FutureBuilder<Widget>(
                future: Ads.getBannerWidget(
                    context: context,
                    adSize: AdSize.banner
                ),
                builder: (_, snapshot){

                  if(!snapshot.hasData){

                    return Text("Carregando...");

                  } else {

                    return Container(
                      height: 90, // 32 / 50 / 90
                      width: MediaQuery.of(context).size.width,
                      child: snapshot.data,
                    );

                  }

                },
              ),

              SizedBox(height: 15),

              Text("CUSTOM SIZED BANNER 300x60"),

              SizedBox(height: 15),

              FutureBuilder<Widget>(
                future: Ads.getBannerWidget(
                    context: context,
                    adSize: AdSize(width: 300, height: 60)
                ),
                builder: (_, snapshot){

                  if(!snapshot.hasData){

                    return Text("Carregando...");

                  } else {

                    return Container(
                      height: 90, // 32 / 50 / 90
                      width: MediaQuery.of(context).size.width,
                      child: snapshot.data,
                    );

                  }

                },
              ),

              SizedBox(height: 15),

              ElevatedButton(
                child: Text("SHOW INTERSTITIAL"),
                onPressed: (){
                  Ads.showInterstitial();
                },
              ),

              SizedBox(height: 15),

              ElevatedButton(
                child: Text("BANNER AS NATIVE ADS"),
                onPressed: (){

                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => BannerNativeAdScreen())
                  );

                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}

