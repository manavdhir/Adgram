import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:instagram_ad_network_app/constants.dart';
import 'package:instagram_ad_network_app/screens/AdvertisersHomePage.dart';
import 'package:instagram_ad_network_app/widgets/TextFieldWidget.dart';
import 'package:instagram_ad_network_app/widgets/TopLottieAnim.dart';

class AdvertisersLogininScreen extends StatefulWidget {
  @override
  _AdvertisersLogininScreenState createState() =>
      _AdvertisersLogininScreenState();
}

class _AdvertisersLogininScreenState extends State<AdvertisersLogininScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  CollectionReference advertisersRef =
      FirebaseFirestore.instance.collection('Advertisers');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
            title: Text(
              'Login for Advertisers',
              style: GoogleFonts.bungee(color: Colors.black),
            ),
            backgroundColor: Colors.white,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                TopLottieAnim(link: 'assets/lottie/loginForAdvertisers.json'),
                TextFieldWidget(
                    title: 'Enter your email',
                    controller: email,
                    textInputType: TextInputType.emailAddress),
                TextFieldWidget(
                    title: 'Enter your password',
                    controller: password,
                    textInputType: TextInputType.visiblePassword),
                Hero(
                  tag: 'hero1',
                  child: GestureDetector(
                    onTap: () {
                      checkAndSaveData();
                    },
                    child: Center(
                      child: Container(
                        margin: EdgeInsets.only(top: 20),
                        padding: EdgeInsets.symmetric(vertical: 15),
                        width: 300,
                        height: 60,
                        child: Center(
                          child: Text('Login as an Advertisers',
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 20)),
                        ),
                        decoration: BoxDecoration(
                            color: Color(0xffffcdab),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }

  void checkAndSaveData() {
    if (email.text == '') {
      Fluttertoast.showToast(msg: "Email cannot be empty");
    }
    if (password.text == '') {
      Fluttertoast.showToast(msg: "Password cannot be empty");
    } else {
      advertisersRef.add({
        'email': email.text,
        'password': password.text,
      }).whenComplete(() => {
            Fluttertoast.showToast(msg: "Login Success"),
            Navigator.push(context,
                MaterialPageRoute(builder: (c) => AdvertisersHomePage())),
          });
    }
  }
}
