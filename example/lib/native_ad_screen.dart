import 'package:djalma_ads/djalma_ads.dart';
import 'package:flutter/material.dart';

class NativeAdScreen extends StatelessWidget {

  int counter = 0;

  @override
  Widget build(BuildContext context) {

    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Native Ad Screen Example"),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: ListView.separated(
          separatorBuilder: (_, index) => index != 0 && index % 4 == 0 ? Ads.getNativeAdmobBannerView():Offstage(),
          itemCount: 20,
          itemBuilder: (context, index){

            return Container(
              margin: EdgeInsets.only(top: 10, bottom: 10),
              color: Colors.blue,
              height: height * 0.30,
              width: width,
              child: Center(
                child: Text(index.toString()),
              ),
            );

          },
        ),
      ),
    );
  }
}
