import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:instagram_ad_network_app/screens/InfluencersloginScreen.dart';
import 'package:instagram_ad_network_app/screens/advertisersLoginScreen.dart';

import 'package:instagram_ad_network_app/widgets/TopLottieAnim.dart';
import 'package:lottie/lottie.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          TopLottieAnim(
            link: 'assets/lottie/logo.json',
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            margin: EdgeInsets.only(top: 30),
            child: Text('Adgram',
                style: GoogleFonts.bungee(
                    fontSize: 40, fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            height: 30,
          ),
          Text('A community for influencers and advertisers'),
          SizedBox(
            height: 30,
          ),
          Hero(
            tag: 'hero1',
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (c) => LoginScreen()));
              },
              child: Center(
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  padding: EdgeInsets.symmetric(vertical: 15),
                  width: 300,
                  height: 60,
                  child: Center(
                    child: Text('Influencer',
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 20)),
                  ),
                  decoration: BoxDecoration(
                      color: Color(0xffc5e3f6),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xffc5e3f6),
                          blurRadius: 5.0,
                        ),
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
              ),
            ),
          ),
          Hero(
            tag: 'hero2',
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (c) => AdvertisersLogininScreen()));
              },
              child: Center(
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  padding: EdgeInsets.symmetric(vertical: 15),
                  width: 300,
                  height: 60,
                  child: Center(
                    child: Text('Advertiser',
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 20)),
                  ),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xfffccde2),
                          blurRadius: 5.0,
                        ),
                      ],
                      color: Color(0xfffccde2),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
