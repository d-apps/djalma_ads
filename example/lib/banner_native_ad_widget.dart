import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerNativeAdWidget extends StatefulWidget {

  final AdSize adSize;

  BannerNativeAdWidget(this.adSize);

  @override
  _BannerNativeAdWidgetState createState() => _BannerNativeAdWidgetState();
}

class _BannerNativeAdWidgetState extends State<BannerNativeAdWidget> with AutomaticKeepAliveClientMixin {

  BannerAd bannerAd;
  bool loaded = false;

  @override
  void initState() {

    bannerAd = BannerAd(
        adUnitId: BannerAd.testAdUnitId,
        size: widget.adSize,
        request:  AdRequest(
            testDevices: ["FC24EF68A748928ED0DBB45F3B2DA749"]
        ),
        listener: AdListener(
            onAdLoaded: (ad){

              setState(() {
                loaded = true;
              });

            },
            onAdFailedToLoad: (ad, error){
              print("ERROR BANNER AD: ${error.message}");
              ad.dispose();
            },
            onApplicationExit: (ad){
              print("onApplicationExit");
              ad.dispose();
            }
        )
    )..load();


    // 320x250 Medium Rectangle Banner

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    super.build(context);

    print("BUILD FROM BANNER AD");

    return Visibility(
      visible: loaded,
      child: Container(
        alignment: Alignment.center,
        width: 468,
        height: 60,
        child: AdWidget(
          ad: bannerAd,
        )
      ),
    );
  }

  @override
  void dispose() {

    print("BANNER AD DISPOSED!");

    //bannerAd?.dispose();
    //bannerAd = null;

    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

}