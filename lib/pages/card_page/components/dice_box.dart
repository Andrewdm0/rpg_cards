import 'package:flutter/material.dart';

class DiceBox extends StatefulWidget {
  DiceBox(
      {Key? key,
      required this.text,
      required this.setChangeSize,
      required this.id})
      : super(key: key);
  String text;
  Function setChangeSize;
  int id;

  @override
  State<DiceBox> createState() => _DiceBoxState();
}

class _DiceBoxState extends State<DiceBox> {
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.setChangeSize(widget.id);
        isClicked ? isClicked = false : isClicked = true;
        setState(() {});
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.center,
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          border: Border.all(
            color: isClicked ? Colors.green : Colors.black,
            width: 2,
          ),
        ),
        child: Text(
          widget.text,
          style: TextStyle(
            fontSize: 30,
          ),
        ),
      ),
    );
  }
}
