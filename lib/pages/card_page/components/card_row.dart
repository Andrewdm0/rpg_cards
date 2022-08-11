import 'package:flutter/material.dart';

class CardRow extends StatelessWidget {
  final String chave, valor;

  const CardRow({required this.chave, required this.valor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(10),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            chave,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Text(
            valor,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
