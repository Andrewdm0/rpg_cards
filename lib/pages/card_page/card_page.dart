import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:rpg_cards/helpers/random_generator.dart';
import 'package:rpg_cards/main.dart';
import 'package:rpg_cards/pages/card_page/components/char_status.dart';
import '../../helpers/send_push.dart';
import '../../models/personagem_bean.dart';
import 'components/card_column.dart';
import 'components/card_image.dart';

class CardPage extends StatefulWidget {
  final PersonagemBean personagemBean;

  CardPage({required this.personagemBean});

  @override
  _CardPageState createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  var numero;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    numero = widget.personagemBean.dado;
  }

  void rollDice() {
    setState(() {
      var random = getRandomNumber();
      if (random != 0) {
        numero = random;
      }
    });
    db
        .collection('characters')
        .doc(widget.personagemBean.id)
        .update({'dado': '$numero'});
    sendPushMessage(numero, widget.personagemBean.nome);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.personagemBean.nome),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              boxShadow: [
                BoxShadow(
                  blurRadius: 3,
                  color: Colors.black,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CharStatus(imageUrl: widget.personagemBean.image),
                  SizedBox(height: 20),
                  CardColumn(personagemBean: widget.personagemBean),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.center,
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                    child: Text(
                      (numero == null) ? '0' : numero.toString(),
                      style: TextStyle(
                        fontSize: 40,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: rollDice,
                    child: Text(
                      'Role os Dados',
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(50, 50),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
