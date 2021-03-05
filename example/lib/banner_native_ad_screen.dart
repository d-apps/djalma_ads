import 'package:example/banner_native_ad_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerNativeAdScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Native Ad"),
      ),

      body: Container(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: 50,
          itemBuilder: (context, index){

            return Column(
              children: [

                ListTile(
                  title: Text("Item $index"),
                ),

                index != 0 && index % 4 == 0 ?
                BannerNativeAdWidget(AdSize.smartBanner) :
                SizedBox.shrink()

              ],
            );

          },
        ),
      ),
    );
  }
}
