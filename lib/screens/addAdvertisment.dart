import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:instagram_ad_network_app/widgets/TextFieldWidget.dart';

class AddAdvertisment extends StatefulWidget {
  @override
  _AddAdvertismentState createState() => _AddAdvertismentState();
}

class _AddAdvertismentState extends State<AddAdvertisment> {
  CollectionReference advertismentsRef =
      FirebaseFirestore.instance.collection('Advertisments');

  TextEditingController title = TextEditingController();
  TextEditingController followersRequired = TextEditingController();
  TextEditingController numberOfPosts = TextEditingController();

  performCheckAndSaveData() {
    if (title.text == '') {
      Fluttertoast.showToast(msg: "Email cannot be empty");
    }
    if (followersRequired.text == '') {
      Fluttertoast.showToast(msg: "Password cannot be empty");
    }
    if (numberOfPosts.text == '') {
      Fluttertoast.showToast(msg: "Followers count cannot be empty");
    } else {
      advertismentsRef.add({
        'title': title.text,
        'followersRequired': followersRequired.text,
        'numberOfPosts': numberOfPosts.text,
      }).whenComplete(() => {
            Fluttertoast.showToast(msg: "Advertisment sucessfully posted"),
            Navigator.pop(context),
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0XffFFD39E),
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              )),
          title: Text(
            'Add a advertisment',
            style: GoogleFonts.bungee(
                fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Container(
                height: (MediaQuery.of(context).size.height),
                color: Color(0XffFFD39E),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(1, 3), // changes position of shadow
                      ),
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(7))),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.85,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //add title text
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Add the title ",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      //title textfield
                      TextFieldWidget(
                          title: 'Title',
                          controller: title,
                          textInputType: TextInputType.text)

                      //followers required text
                      ,
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Followers Required",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),

                      //number of followers textField

                      TextFieldWidget(
                          title: 'Number of Followers',
                          controller: followersRequired,
                          textInputType: TextInputType.number)

                      //number of posts text
                      ,
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Number of posts required ",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),

                      //number of posts textfield
                      TextFieldWidget(
                          title: 'Number of posts',
                          controller: numberOfPosts,
                          textInputType: TextInputType.number)

                      //add note to firebase button
                      ,
                      InkWell(
                        onTap: () {
                          performCheckAndSaveData();
                        },
                        child: Center(
                          child: Container(
                            margin: EdgeInsets.only(top: 20),
                            padding: EdgeInsets.symmetric(vertical: 15),
                            width: 300,
                            child: Center(
                              child: Text(
                                "Add Advertisment",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 18),
                              ),
                            ),
                            decoration: BoxDecoration(
                                color: Color(0XffFFD39E),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
