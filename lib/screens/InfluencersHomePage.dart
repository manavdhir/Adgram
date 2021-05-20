import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:instagram_ad_network_app/colors.dart';
import 'package:instagram_ad_network_app/images.dart';
import 'package:instagram_ad_network_app/screens/homeScreen.dart';
import 'package:lottie/lottie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InfluencersHomePage extends StatefulWidget {
  @override
  _InfluencersHomePageState createState() => _InfluencersHomePageState();
}

class _InfluencersHomePageState extends State<InfluencersHomePage> {
  final influencersRef = FirebaseFirestore.instance.collection('Advertisments');

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
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            _showAlertDailog(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: Text(
          'Influencers Home',
          style: GoogleFonts.bungee(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
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
                            Container(
                              margin: EdgeInsets.all(10),
                              child: Text(
                                  getDocumentsItems(snapshot, index)['title'],
                                  style: GoogleFonts.bungee(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)),
                            ),
                            Text('Requirements',
                                style: TextStyle(
                                  color: Colors.grey,
                                )),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Icon(CupertinoIcons.profile_circled),
                                    Text(getDocumentsItems(
                                        snapshot, index)['followersRequired'])
                                  ],
                                ),
                                Column(
                                  children: [
                                    Icon(CupertinoIcons.photo),
                                    Text(getDocumentsItems(
                                        snapshot, index)['numberOfPosts'])
                                  ],
                                ),
                              ],
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
                        'No registered Advertisments',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 15),
                      )
                    ],
                  ));
          }),
    );
  }
}
