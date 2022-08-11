import 'package:flutter/material.dart';

class AddTextField extends StatelessWidget {
  final String label,hint;
  final TextEditingController controller;

  const AddTextField({Key? key, required this.label, required this.hint, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
              Radius.circular(10.0)), // Set rounded corner radius
          boxShadow: [
            BoxShadow(
              blurRadius: 3,
              color: Colors.black,
              spreadRadius: 0,
            )
          ] // Make rounded corner of border
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            border: InputBorder.none,
            labelText: label,
            hintText: hint),
      ),
    );
  }
}
