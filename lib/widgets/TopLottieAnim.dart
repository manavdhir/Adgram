import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class TopLottieAnim extends StatelessWidget {
  final String link;
  TopLottieAnim({required this.link});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 50),
      child: Center(child: Lottie.asset(link, height: 300, width: 300)),
    );
  }
}
