import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class BotaoDropDown extends StatefulWidget {
  BotaoDropDown({Key? key, required this.callback, required this.classeText})
      : super(key: key);
  String? classeText;
  Function callback;

  @override
  State<BotaoDropDown> createState() => _BotaoDropDownState();
}

class _BotaoDropDownState extends State<BotaoDropDown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
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
        ], // Make rounded corner of border
      ),
      child: Row(
        children: [
          Text('Classe do persongagem  '),
          Expanded(
            child: DropdownButton(
              isExpanded: true,
              hint: Text('Classe'),
              alignment: Alignment.bottomRight,
              value: widget.classeText,
              items: <String>['Mago', 'Guerreiro']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  widget.classeText = newValue!;
                  widget.callback(newValue);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
