import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String title;
  final TextInputType textInputType;
  final TextEditingController controller;
  TextFieldWidget(
      {required this.title,
      required this.controller,
      required this.textInputType});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.withOpacity(0.2),
        ),
        padding: EdgeInsets.all(10),
        child: TextField(
          keyboardType: textInputType,
          controller: controller,
          style: TextStyle(fontSize: 18),
          decoration:
              InputDecoration(hintText: title, border: InputBorder.none),
        ),
      ),
    );
  }
}
