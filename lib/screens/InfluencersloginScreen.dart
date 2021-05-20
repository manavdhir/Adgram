import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:instagram_ad_network_app/constants.dart';
import 'package:instagram_ad_network_app/screens/InfluencersHomePage.dart';
import 'package:instagram_ad_network_app/widgets/TextFieldWidget.dart';
import 'package:instagram_ad_network_app/widgets/TopLottieAnim.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  CollectionReference influencersRef =
      FirebaseFirestore.instance.collection('Influencers');

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController numberOfFollowers = TextEditingController();
  TextEditingController numberOfPosts = TextEditingController();
  TextEditingController typeOfAudience = TextEditingController();
  TextEditingController userName = TextEditingController();

  performCheckAndSaveData() {
    if (email.text == '') {
      Fluttertoast.showToast(msg: "Email cannot be empty");
    }
    if (password.text == '') {
      Fluttertoast.showToast(msg: "Password cannot be empty");
    }
    if (numberOfFollowers.text == '') {
      Fluttertoast.showToast(msg: "Followers count cannot be empty");
    }
    if (numberOfPosts.text == '') {
      Fluttertoast.showToast(msg: "Posts count cannot be empty");
    }
    if (typeOfAudience.text == '') {
      Fluttertoast.showToast(msg: "Audience count cannot be empty");
    }
    if (userName.text == '') {
      Fluttertoast.showToast(msg: "Username cannot be empty");
    } else {
      influencersRef.add({
        'email': email.text,
        'password': password.text,
        'numberOfFollowers': numberOfFollowers.text,
        'numberOfPosts': numberOfPosts.text,
        'TypeOfAudience': typeOfAudience.text,
        'username': userName.text
      }).whenComplete(() => {
            Fluttertoast.showToast(msg: "Login Success"),
            Navigator.push(context,
                MaterialPageRoute(builder: (c) => InfluencersHomePage())),
          });
    }
  }

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
              'Login for Influencers',
              style: GoogleFonts.bungee(color: Colors.black),
            ),
            backgroundColor: Colors.white,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(right: 20, bottom: 20, top: 20),
                    child: LottieBuilder.asset(
                        'assets/lottie/loginForInfulencers.json')),

                //email
                TextFieldWidget(
                  title: 'Enter your email',
                  controller: email,
                  textInputType: TextInputType.emailAddress,
                ),
                //password
                TextFieldWidget(
                  title: 'Enter your password',
                  controller: password,
                  textInputType: TextInputType.visiblePassword,
                ), //number of followers
                //username
                TextFieldWidget(
                  title: 'Enter your Instagram username',
                  controller: userName,
                  textInputType: TextInputType.text,
                ), //number of followers

                //number of followers
                TextFieldWidget(
                  title: 'Number of followers',
                  controller: numberOfFollowers,
                  textInputType: TextInputType.number,
                ), //number of posts
                //number of posts
                TextFieldWidget(
                  title: 'Number of posts',
                  controller: numberOfPosts,
                  textInputType: TextInputType.number,
                ), //type of audience
                //type of audience
                TextFieldWidget(
                  title: 'Type of audience',
                  controller: typeOfAudience,
                  textInputType: TextInputType.text,
                ), //submit button
                Hero(
                  tag: 'hero1',
                  child: GestureDetector(
                    onTap: () {
                      performCheckAndSaveData();
                    },
                    child: Center(
                      child: Container(
                        margin: EdgeInsets.only(top: 20, bottom: 50),
                        padding: EdgeInsets.symmetric(vertical: 15),
                        width: 300,
                        height: 60,
                        child: Center(
                          child: Text('Login as an Influencer',
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
}
