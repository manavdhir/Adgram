import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:instagram_ad_network_app/colors.dart';
import 'package:instagram_ad_network_app/constants.dart';
import 'package:instagram_ad_network_app/images.dart';
import 'package:instagram_ad_network_app/screens/addAdvertisment.dart';
import 'package:instagram_ad_network_app/screens/homeScreen.dart';
import 'package:lottie/lottie.dart';

class AdvertisersHomePage extends StatefulWidget {
  @override
  _AdvertisersHomePageState createState() => _AdvertisersHomePageState();
}

class _AdvertisersHomePageState extends State<AdvertisersHomePage> {
  final influencersRef = FirebaseFirestore.instance.collection('Influencers');

  getDocumentLength(AsyncSnapshot<QuerySnapshot> snapshot) {
    if (snapshot.hasData) {
      final List<DocumentSnapshot> documents = snapshot.data!.docs;
      return documents.length;
    } else {
      return 0;
    }
  }

  getDocumentsItems(AsyncSnapshot<QuerySnapshot> snapshot, int index) {
    if (snapshot.hasData) {
      final List<DocumentSnapshot> documents = snapshot.data!.docs;
      return documents[index];
    } else {
      return 0;
    }
  }

  var random = new Random();

  void _showAlertDailog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text(
              'Are you sure you want to logout ?',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            actions: [
              new FlatButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (c) => MyHomePage()));
                  },
                  child: new Text(
                    'Yes',
                    style: TextStyle(color: Colors.red),
                  )),
              new FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: new Text(
                    'No',
                    style: TextStyle(color: Colors.black),
                  )),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: AppBar(
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (c) => AddAdvertisment()));
                },
                icon: Icon(
                  Icons.post_add,
                ),
                color: Colors.black,
              )
            ],
            leading: GestureDetector(
                onTap: () {
                  _showAlertDailog(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                )),
            backgroundColor: Colors.white,
            title: Text('Advertisers Home', style: kAppBarHeadingStyle),
          ),
          preferredSize: Size.fromHeight(60)),
      body: StreamBuilder(
          stream: influencersRef.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return getDocumentLength(snapshot) != 0
                ? GridView.builder(
                    padding: EdgeInsets.only(bottom: 20),
                    clipBehavior: Clip.hardEdge,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemCount: getDocumentLength(snapshot),
                    itemBuilder: (_, index) {
                      return Container(
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 2.0,
                              ),
                            ],
                            color: randomColors[random.nextInt(8)],
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        margin: EdgeInsets.all(20),
                        child: SingleChildScrollView(
                            child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    child: Column(
                                  children: [
                                    Image.asset(
                                      randomImages[random.nextInt(3)],
                                      width: 70,
                                      height: 70,
                                    ),
                                    Text(
                                        getDocumentsItems(
                                            snapshot, index)['TypeOfAudience'],
                                        style: GoogleFonts.bungee(
                                            color: Colors.black, fontSize: 15))
                                  ],
                                )),
                                Expanded(
                                    child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Icon(
                                          CupertinoIcons.profile_circled,
                                          color: Colors.black,
                                          size: 25,
                                        ),
                                        Icon(Icons.image,
                                            color: Colors.black, size: 25)
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          getDocumentsItems(snapshot, index)[
                                              'numberOfFollowers'],
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                            getDocumentsItems(snapshot, index)[
                                                'numberOfPosts'],
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold))
                                      ],
                                    ),
                                  ],
                                ))
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Text(
                                getDocumentsItems(snapshot, index)['email'],
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Text(
                                'username : ${getDocumentsItems(snapshot, index)['username']}',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                            )
                          ],
                        )),
                      );
                    })
                : Center(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LottieBuilder.network(
                        'https://assets3.lottiefiles.com/packages/lf20_W4M8Pi.json',
                        height: 500,
                        width: 500,
                      ),
                      Text(
                        'No registered influencers',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 15),
                      )
                    ],
                  ));
          }),
    );
  }
}
